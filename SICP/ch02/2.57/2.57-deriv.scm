(load "2.57-addend.scm")
(load "2.57-augend.scm")
(load "2.57-make-product.scm")
(load "2.57-multiplicand.scm")
(load "2.57-multiplier.scm")
(load "2.57-sum.scm")
(load "2.57-variable.scm")
(load "2.57-same-variable.scm")
(load "2.57-product.scm")
(load "2.57-make-sum.scm")
(load "2.57-exponentiation.scm")
(load "2.57-base.scm")
(load "2.57-exponent.scm")
(load "2.57-make-exponentiation.scm")
(define (deriv expression var)
  (display "deriv ")
  (display expression)
  (display "  ")
  (display var)
  (newline)
  (cond ((number? expression) 0)
	((variable? expression)
	 (display "variable ")
	 (display expression)
	 (newline)
	 (if (same-variable? expression var) 
	     1 
	     0))
	((sum? expression) 
	 (display "sum ")
	 (display expression)
	 (newline)
	 (make-sum (deriv (addend expression) var)
		   (deriv (augend expression) var)))
	((product? expression)
	 (display "product ")
	 (display expression)
	 (newline)
	 (make-sum
	   (make-product (multiplier expression)
			 (deriv (multiplicand expression) var))
	   (make-product (deriv (multiplier expression) var)
			 (multiplicand expression))))
	((exponentiation? expression)
	 (let ((b (base expression))
	       (e (exponent expression)))
	   (let ((new-e (make-sum e (- 1)))
		 (new-b (deriv b var)))
	     (cond ((and (number? (deriv e var)) (= (deriv e var) 0)) (make-product e (make-product new-b (make-exponentiation b new-e))))
		   (else (error "not know what to do" expression))))))
	(else (error "unknown expression type --- DERIV" expression))))
