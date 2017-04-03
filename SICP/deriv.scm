(define (deriv exp var)
 (cond ((null? exp) '())
	   ((number? exp) 0)
	   ((variable? exp) (if (eq? exp var) 1 0))
	   ((sum-exp? exp) (make-sum (deriv (first-operand exp) var) (deriv (second-operand exp) var)))
	   ((mul-exp? exp) (make-sum (make-mul (deriv (first-operand exp) var) (second-operand exp))
												            (make-mul (first-operand exp) (deriv (second-operand exp) var))))
	   (else (error "no such operation -- deriv" exp))))


(define (operator exp) (car exp))
(define (first-operand exp) (cadr exp))
(define (second-operand exp) (caddr exp))

(define (variable? exp) (and (not (pair? exp)) (symbol? exp)))
(define (sum-exp? exp) (and (pair? exp) (eq? '+ (operator exp))))
(define (mul-exp? exp) (and (pair? exp) (eq? '* (operator exp))))

(define (make-sum x1 x2)
 (cond ((and (number? x1) (= x1 0)) x2)
	   ((and (number? x2) (= x2 0)) x1)
	   ((and (number? x1) (number? x2)) (+ x1 x2))
	   (else (list '+ x1 x2))))

(define (make-mul x1 x2)
 (cond ((or (and (number? x1) (= x1 0)) (and (number? x2) (= x2 0))) 0)
	   ((and (number? x1) (= x1 1)) x2)
	   ((and (number? x2) (= x2 1)) x1)
	   ((and (number? x1) (number? x2)) (* x1 x2))
	   (else (list '* x1 x2))))
	   
