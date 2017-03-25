(define (let*? exp) (tagged-list? exp 'let*))

(define (let*-var-exp exp) (cadr exp))

(define (let*-body exp) caddr exp)

(define (make-let var-exp body)
  (list 'let var-exp body))

(define (make-let* var-exp body)
  (list 'let* var-exp body))

(define (let*-nested-lets exp)
  (let ((var-exp (let*-var-exp exp))
	(body (let*-body exp)))
    (let ((first (car var-exp))
	  (rest (cdr var-exp)))
      (if (null? rest)
	(make-let (list first) body)
	(make-let (list first) (let*-nested-lets (make-let* rest body)))))))

;;;((let*? exp) (eval (let*-nested-lets exp) env))
