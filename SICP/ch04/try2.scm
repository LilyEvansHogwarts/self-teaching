(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
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
	((cond? exp)
	 (eval (cond->if exp) env))
	((application? exp)
	 (apply-inner (eval (operator exp) env)
		      (list-of-values (operands exp) env)))
	(else (error "Unknown expression type -- EVAL" exp))))

;;;*****************************************************************

(define (self-evaluating? exp)
  (cond ((string? exp) true)
	((number? exp) true)
	(else false)))

;;;*****************************************************************

(define (variable? exp)
  (symbol? exp))

;;;*****************************************************************

(define (text-of-quotation exp)
  (cadr exp))

(define (tagged-list? exp tag)
  (if (pair? exp)
    (eq? (car exp) tag)
    false))

(define (quoted? exp)
  (tagged-list? exp 'quote))

;;;*****************************************************************

(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp)
  (cadr exp))

(define (assignment-value exp)
  (caddr exp))

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
		       (eval (assignment-value exp) env)
		       env)
'ok)

;;;****************************************************************

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

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
		    (eval (definition-value exp) env)
		    env)
  'ok)

;;;***************************************************************

(define (lambda? exp)
  (tagged-list? exp 'lambda))

(define (lambda-parameters exp)
  (cadr exp))

(define (lambda-body exp)
  (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;;;***************************************************************

(define (if? exp)
  (tagged-list? exp 'if))

(define (if-predicate exp)
  (cadr exp))

(define (if-consequent exp)
  (caddr exp))

(define (if-alternative exp)
  (cadddr exp))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
    (eval (if-consequent exp) env)
    (eval (if-alternative exp) env)))

;;;***************************************************************

(define (begin? exp)
  (tagged-list? exp 'begin))

(define (begin-actions exp)
  (cdr exp))

(define (make-begin seq)
  (cons 'begin seq))

(define (last-exp? seq) (null? (cdr seq)))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
	((last-exp? seq) (eval (first-exp seq) env))
	(else (make-begin seq))))

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
	(else (eval (first-exp exps) env)
	      (eval-sequence (rest-exps exps) env))))

;;;**************************************************************

(define (application? exp)
  (pair? exp))

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

;;;**************************************************************

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
    '()
    (let ((first (car clauses))
	  (rest (cdr clauses)))
      (if (cond-else-clause? first)
	(if (null? rest)
	  (sequence->exp (cond-actions first))
	  (error "ELSE clause isn't last -- COND->IF" clauses))
	(make-if (cond-predicate first)
		 (sequence->exp (cond-actions first))
		 (expand-clauses rest))))))

;;;****************************************************************

(define (true? x)
  (not (eq? x false)))

(define (false? x)
  (eq? x false))

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
	  (list-of-values (rest-operands exps) env))))

(define (apply-inner procedure arguments)
  (cond ((primitive-procedure? procedure)
	 (apply-primitive-procedure procedure arguments))
	((compound-procedure? procedure)
	 (eval-sequence (procedure-body procedure)
			(extend-environment (procedure-parameters procedure)
					    arguments
					    (procedure-environment procedure))))
	(else (error "Unknown procedure type -- APPLY-INNER" procedure))))

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (procedure-parameters p)
  (cadr p))

(define (procedure-body p)
  (caddr p))

(define (procedure-environment p)
  (cadddr p))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (primitive-procedure? p)
  (tagged-list? p 'primitive))

(define (enclosing-environment env) (cdr env))

(define the-empty-environment '())

(define (make-frame vars vals)
  (cons vars vals))

(define (first-frame env)
  (car env))

(define (frame-variables frame)
  (car frame))

(define (frame-values frame)
  (cdr frame))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (scan var vars vals)
  (cond ((null? vars) false)
	((eq? (car vars) var) (car vals))
	(else (scan var (cdr vars) (cdr vals)))))

(define (env-loop var env)
  (if (eq? env the-empty-environment)
    false
    (let ((frame (first-frame env)))
      (let ((val (scan var (frame-variables frame) (frame-values frame))))
	(if val
	  val 
	  (env-loop var (enclosing-environment env)))))))

(define (lookup-variable-value var env)
  (env-loop var env))

(define (set-variable-value! var val env)
  (let ((value (env-loop var env)))
    (if value
      (set! value val)
      (error "Unbound variable" var))))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (let ((value (scan var (frame-variables frame) (frame-values frame))))
      (if value
	(set! value val)
	(add-binding-to-frame! var val frame)))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
    (cons (make-frame vars vals) base-env)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

(define (setup-environment)
  (let ((initial-env 
	  (extend-environment (primitive-procedure-names)
			      (primitive-procedure-objects)
			      the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define primitive-procedures
  (list (list 'car car)
	(list 'cdr cdr)
	(list 'cons cons)
	(list 'null? null?)
	(list 'eq? eq?)))

(define (primitive-procedure-names)
  (map car primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc))) primitive-procedures))

(define (primitive-implementation proc)
  (cadr proc))

(define (apply-primitive-procedure proc args)
  (apply (primitive-implementation proc) args))

(define input-prompt ";;;M-Eval input:")
(define output-prompt ";;;M-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

(define (prompt-for-input string)
  (newline)
  (newline)
  (display string)
  (newline))

(define (announce-output string)
  (newline)
  (display string)
  (newline))

(define (user-print object)
  (if (compound-procedure? object)
    (display (list 'compound-procedure
		   (procedure-parameters procedure)
		   (procedure-body procedure)
		   '<procedure-env>))
    (display object)))

(define the-global-environment (setup-environment))
(driver-loop)
