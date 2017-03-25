(define (named-let? exp) (and (let? exp) (symbol? (cadr exp))))

(define (named-let-func-name exp) (cadr exp))

(define (named-let-func-parameters exp) (map car (caddr exp)))

(define (named-let-func-inits exp) (map cdr (caddr exp)))

(define (named-let-func-body exp) (cadddr exp))

(define (named-let->func exp)
  (list 'define 
	(cons (named-let-func-name exp) (named-let-func-parameters exp))
	(named-let-func-body exp)))

(define (let-var exp) (map car (cadr exp)))

(define (let-exp exp) (map cdr (cadr exp)))

(define (let-body exp) (caddr exp))

(define (let->combination exp)
  (if (named-let? exp)
    (sequence->exp (list (named-let->func exp)
			 (cons (named-let-func-name exp) (named-let-func-inits exp))))
    (cons (make-lambda (let-var exp)
		       (let-body exp))
	  (let-exp exp))))
