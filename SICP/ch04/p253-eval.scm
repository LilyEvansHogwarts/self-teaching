(load "p255-evaluator.scm")
(load "p264-procedure.scm")
(load "p261-procedure.scm")

(define (eval exp env)
  (cond ((self-evaluation? exp) exp)
	((variable? exp) (lookup-variable-value exp env))
	((quoted? exp) (text-of-quotation exp))
	((assignment? exp) (eval-assignment exp env))
	((definition? exp) (eval-definition exp env))
	((if? exp) (eval-if exp env))
	((lambda? exp) 
	 (make-procedure (lambda-parameters exp)
			 (lambda-body exp)
			 env))
	((begin? exp)
	 (eval-sequence (begin-actions exp) env))
	((cond? exp) (eval (cond->if exp) env))
	((application? exp) 
	 (apply-inner (eval (operator exp) env)
		(list-of-values (operands exp) env)))
	(else 
	  (error "Unknown expression type -- EVAL" exp))))


(define the-global-environment (setup-environment))



