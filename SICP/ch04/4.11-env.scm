(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p)
  (cadr p))

(define (procedure-body p)
  (caddr p))

(define (procedure-environment p)
  (cadddr p))

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (add-binding-to-frame! var val frame)
  (set! frame (cons (cons var val) frame)))

(define (extended-environment frame base-env)
  (cons frame base-env))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan frame)
      (cond ((null? frame)
	     (env-loop (enclosing-environment env)))
	    ((eq? var (caar frame))
	     (cdar frame))
	    (else (scan (cdr frame)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (car env)))
	(scan frame))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan frame)
      (cond ((null? frame) 
	     (env-loop (enclosing-environment env)))
	    ((eq? var (caar frame))
	     (set-cdr! (car frame) val))
	    (else (scan (cdr frame)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
	(scan frame))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan frame)
      (cond ((null? frame)
	     (add-binding-to-frame! var val frame))
	    ((eq? var (caar frame))
	     (set-cdr! (car frame) val))
	    (else (scan (cdr frame)))))
    (scan frame)))
