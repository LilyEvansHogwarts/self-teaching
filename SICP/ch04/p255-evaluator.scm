(load "p264-procedure.scm")
(load "p261-procedure.scm")
;;;**********************************************
;;;               self-evaluating?
;;;**********************************************

(define (self-evaluating? exp)
  (cond ((number? exp) true)
	((string? exp) true)
	(else false)))

;;;**********************************************
;;;                 variable?
;;;       (lookup-variable-value exp env)
;;;**********************************************

(define (variable? exp) (symbol? exp))

;;;**********************************************
;;;                  quoted?
;;;           (text-of-quotation exp)
;;;**********************************************

(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp)
  (cadr exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
    (eq? (car exp) tag)
    false))

;;;**********************************************
;;;                  assignment?
;;;          (eval-assignment exp env)
;;;**********************************************

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
		       (eval (assignment-value exp) env)
		       env)
  'ok)

(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

;;;**********************************************
;;;                 definition?
;;;          (eval-definition exp env)
;;;**********************************************

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
		    (eval (definition-value exp) env)
		    env)
  'ok)

(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
    (cadr exp)
    (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
    (caddr exp)
    (make-lambda (cdadr exp) 
		 (cddr exp))))

;;;**********************************************
;;;                    lambda?
;;;(make-procedure (lambda-parameters exp)
;;;                (lambda-body exp)
;;;		   env))
;;;**********************************************

(define (lambda? exp)
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp)
  (cadr exp))

(define (lambda-body exp)
  (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;;;*********************************************
;;;                     if?
;;;              (eval-if exp env)
;;;*********************************************

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
    (eval (if-consequent exp) env)
    (eval (if-alternative exp) env)))

(define (if? exp)
  (tagged-list? exp 'if))

(define (if-prediction exp)
  (cadr exp))

(define (if-consequent exp)
  (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
    (cadddr exp)
    'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;;;**********************************************
;;;                  begin?
;;;   (eval-sequence (begin-actions exp) env)
;;;**********************************************

(define (eval-sequence exps env)
  (cond ((last-exp? exps) 
	 (eval (first-exp exps) env))
	(else
	  (eval (first-exp exps) env)
	  (eval-sequence (rest-exps exps) env))))

(define (begin? exp)
  (tagged-list? exp 'begin))

(define (begin-actions exp)
  (cdr exp))

(define (last-exp? seq)
  (null? (cdr seq)))

(define (first-exp seq)
  (car seq))

(define (rest-exps seq)
  (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
	((last-exp? seq) (first-exp seq))
	(else (make-begin seq))))

(define (make-begin seq) (cons 'begin seq))

;;;*********************************************
;;;                 application?
;;;      (apply (eval (operator exp) env)
;;;		(list-of-values (operands exp) env))
;;;*********************************************

(define (apply-inner procedure arguments)
  (cond ((primitive-procedure? procedure)
	 (apply-primitive-procedure procedure arguments))
	((compound-procedure? procedure)
	 (eval-sequence (procedure-body procedure)
			(extend-environment
			  (procedure-parameters procedure)
			  arguments
			  (procedure-environmrnt procedure))))
	(else 
	  (error "Unknown procedure type -- APPLY" procedure))))

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
	  (list-of-values (rest-operands exps) env))))

(define (application? exp)
  (pairs? exp))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))

(define (no-operands? ops)
  (null? ops))

(define (first-operand ops)
  (car ops))

(define (rest-operands ops)
  (cdr ops))

;;;*********************************************
;;;                    cond?
;;;        (eval (cond->if exp) env)
;;;*********************************************

(define (cond? exp)
  (tagged-list? exp 'cond))

(define (cond-clauses exp)
  (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause)
  (car clause))

(define (cond-actions clause)
  (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
	  (rest (cdr clauses)))
      (if (cond-else-clause? first)
	(if (null? rest)
	  (sequence->exp (cond-actions first))
	  (error "ELSE clause isn't last -- COND->IF" clauses))
	(make-if (cond-predicate first)
		 (sequence->exp (cond-actions first))
		 (expand-clauses rest))))))
