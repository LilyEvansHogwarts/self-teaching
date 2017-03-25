(load "p123-put-and-get.scm")

(define (deriv expression var)
  (cond ((number? expression) 0)
	((variable? expression) (if (same-variable? expression var) 1 0))
	(else ((get 'deriv (operator expression)) (operands expression) var))))

(define (operator expression) (car expression))

(define (operands expression) (cdr expression))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (variable? v1)
  (symbol? v1))
