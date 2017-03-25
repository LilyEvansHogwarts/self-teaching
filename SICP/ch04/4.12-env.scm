(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (add-binding-to-frame! var val frame)
  (set! frame (cons (cons var val) frame)))

(define (extended-environment frame base-env)
  (cons frame base-env))

(define (lookup-variable-in-frame var frame)
  (cond ((null? frame) 'false)
	((eq? var (caar frame)) (car frame))
	(else (lookup-variable-in-frame var (cdr frame)))))

(define (lookup-variable-value var env)
  (if (eq? env the-empty-environment)
    (error "Unbound variable" var)
    (let ((frame (first-frame env)))
      (let ((item (lookup-variable-in-frame var frame)))
	(if item
	  (cdr item)
	  (lookup-variable-value var (enclosing-environment env)))))))

(define (set-variable-value! var val env)
  (if (eq? env the-empty-environment)
    (error "Unbound variable" var)
    (let ((frame (first-frame env)))
      (let ((item (lookup-variable-in-frame var frame)))
	(if item
	  (set-cdr! item val)
	  (set-variable-value! var val (enclosing-environment env)))))))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (let ((item (lookup-variable-in-frame var frame)))
      (if item
	(set-cdr! item val)
	(add-binding-to-frame! var val frame)))))
