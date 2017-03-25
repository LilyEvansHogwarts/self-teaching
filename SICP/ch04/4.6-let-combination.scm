(define (let-var-exp exp) (cadr exp))

(define (let-body) (caddr exp))

(define (map f lst)
  (if (null? lst)
    '()
    (cons (f (car lst)) (map f (cdr lst)))))

(define (let-var exp) (map car (let-var-exp exp)))

(define (let-exp exp) (map cdr (let-var-exp exp)))

(define (let->combination exp)
  (apply (make-lambda (let-var exp) (let-body exp))
	(let-exp exp)))

(define (let? exp)
  (tagged-list? exp 'let))

;;;((let? exp) (eval (let->combination exp) env))
