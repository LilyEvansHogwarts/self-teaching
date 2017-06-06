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

(define (self-evaluating? exp)
 (cond ((string? exp) true)
	   ((number? exp) true)
	   (else false)))

(define (variable? exp) (symbol? exp))

(define (quoted? exp) (tagged-list? exp 'quote))

(define (tagged-list? exp tag) 
 (if (pair? exp)
  (eq? tag (car exp))
  false))

(define (text-of-quotation exp) (cadr exp))

(define (assignment? exp) (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

(define (eval-assignment exp env)
 (set-variable-value! (assignment-variable exp)
					  (eval (assignment-value exp) env) 
					  env)
 'ok)

(define (definition? exp)
 (tagged-list? exp 'define))

(define (definition-variable exp) 
 (if (pair? (cadr exp))
  (caadr exp)
  (cadr exp)))

(define (definition-value exp)
 (if (pair? (cadr exp))
  (make-lambda (cdadr exp) (cddr exp))
  (caddr exp)))

(define (eval-definition exp env)
 (define-variable! (definition-variable exp)
				   (eval (definition-value exp) env)
				   env)
 'ok)

(define (if? exp) (tagged-list? exp 'if))

(define (if-prediction exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp) (cadddr exp))

(define (make-if prediction consequent alternative)
 (list 'if prediction consequent alternative))

(define (eval-if exp env)
 (if (eval (if-prediction exp) env)
  (eval (if-consequent exp) env)
  (eval (if-alternative exp) env)))

(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
 (cons 'lambda (cons parameters body)))

(define (begin? exp) (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (last-exp? exps) (null? (cdr exps)))

(define (first-exp exps) (car exps))

(define (rest-exps exps) (cdr exps))

(define (eval-sequence exps env)
 (cond ((last-exp? exps) (eval (first-exp exps) env))
	   (else (eval (first-exp exps) env)
			 (eval-sequence (rest-exps exps) env))))

(define (sequence->exp seq)
 (cond ((null? seq) seq)
	   ((last-exp? seq) (first-exp seq))
	   (else (make-begin seq))))

(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond-else-clause? clause)
 (eq? (cond-predicate clause) 'else))

(define (expand-clauses clauses)
 (if (null? clauses)
  'false
  (let ((first (first-exp clauses))
		(rest (rest-exps clauses)))
   (if (cond-else-clause? first)
	(if (null? rest)
	 (sequence->exp (cond-actions first))
	 (error "ELSE isn't the last expression -- COND->IF" clauses))
	(make-if (cond-predicate first)
			 (sequence->exp (cond-actions first))
			 (expand-clauses rest))))))

(define (application? exp) (pair? exp))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (no-operands? ops) (null? ops))

(define (first-operand ops) (car ops))

(define (rest-operands ops) (cdr ops))

(define (apply-inner proc args)
 (cond ((primitive-procedure? proc)
		(apply-primitive-procedure proc args))
	   ((compound-procedure? proc)
		(eval-sequence (procedure-body proc)
					   (extend-environment (procedure-parameters proc)
										   args
										   (procedure-env proc))))
	   (else (error "Unknown procedure type -- APPLY" proc))))

(define (list-of-values exps env)
 (if (null? exps)
  '()
  (cons (eval (first-exp exps) env)
		(list-of-values (rest-exps exps) env))))

(define primitive-procedures
 (list (list 'car car)
	   (list 'cdr cdr)
	   (list 'cons cons)
	   (list 'null? null?)
	   (list 'display display)
	   (list '+ +)
	   (list '- -)
	   (list '* *)
	   (list '/ /)
	   (list 'eq? eq?)))

(define (primitive-procedure-names)
 (map car primitive-procedures))

(define (primitive-procedure-objects)
 (map (lambda (proc) (list 'primitive (primitive-implementation proc))) primitive-procedures))

(define (primitive-implementation proc) (cadr proc))

(define (make-procedure parameters body env)
 (list 'procedure parameters body env))

(define (procedure-parameters p) (cadr p))

(define (procedure-body p) (caddr p))

(define (procedure-env p) (cadddr p))

(define (primitive-procedure? p) (tagged-list? p 'primitive))

(define (compound-procedure? p) (tagged-list? p 'procedure))

(define (apply-primitive-procedure proc args)
 (apply (primitive-implementation proc) args))

(define (enclosing-env env) (cdr env))

(define the-empty-environment '())

(define (first-frame env) (car env))

(define (make-frame vars vals) (cons vars vals))

(define (frame-variables frame) (car frame))

(define (frame-values frame) (cdr frame))

(define (add-binding-to-frame! var val frame)
 (set-car! frame (cons var (car frame)))
 (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
 (if (= (length vars) (length vals))
  (cons (make-frame vars vals) base-env)
  (if (< (length vars) (length vals))
   (error "Too many variables" vars vals)
   (error "Too few variables" vars vals))))

(define (env-loop env var)
 (define (scan vars vals)
  (cond ((null? vars) (env-loop (enclosing-env env) var))
		((eq? (car vars) var) vals)
		(else (scan (cdr vars) (cdr vals)))))
 (if (eq? env the-empty-environment)
  false
  (let ((frame (first-frame env)))
   (scan (frame-variables frame) (frame-values frame))))) 


(define (lookup-variable-value var env)
 (let ((vals (env-loop env var)))
  (if vals
   (car vals)
   (error "No such variable" var))))

(define (set-variable-value! var val env)
 (let ((vals (env-loop env var)))
  (if vals
   (set-car! vals val)
   (error "No such variable" var))))

(define (define-variable! var val env)
 (let ((frame (first-frame env)))
  (let ((vals (env-loop (list frame) var)))
   (if vals
	(set-car! vals val)
	(add-binding-to-frame! var val frame)))))

(define (setup-environment)
 (let ((initial-env (extend-environment (primitive-procedure-names)
										(primitive-procedure-objects)
										the-empty-environment)))
  (define-variable! 'true true initial-env)
  (define-variable! 'false false initial-env)
  initial-env))

(define the-global-environment (setup-environment))

(define input-prompt ";;;M-Eval input:")
(define output-prompt ";;;M-Eval value:")

(define (prompt-for-input string)
 (newline) (newline) (display string) (newline))

(define (announce-output string)
 (newline) (display string) (newline))

(define (user-print object)
 (if (compound-procedure? object)
  (display (list 'compound-procedure
				 (procedure-parameters object)
				 (procedure-body object)
				 '<procedure-env>))
  (display object)))

(define (driver-loop)
 (prompt-for-input input-prompt)
 (let ((input (read)))
  (let ((output (eval input the-global-environment)))
   (announce-output output-prompt)
   (user-print output)))
 (driver-loop))

(define (interpret exp) (eval exp the-global-environment))
