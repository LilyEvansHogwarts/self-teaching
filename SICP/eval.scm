(define (eval exp env)
 (cond ((self-evaluating? exp) exp)
	   ((quoted? exp) (text-of-quotation exp))
	   ((variable? exp) (lookup-variable-value exp env))
	   ((assignment? exp) (eval-assignment exp env))
	   ((definition? exp) (eval-definition exp env))
	   ((if? exp) (eval-if exp env))
	   ((lambda? exp) (make-procedure (lambda-parameters exp)
									  (lambda-body exp)
									  env))
	   ((begin? exp) (eval-sequence (begin-actions exp) env))
	   ((cond? exp) (eval (cond->if exp) env))
	   ((application? exp)
		(apply-inner (eval (operator exp) env)
		 (list-of-values (operands exp) env)))
	   (else (error "Unknown operation -- EVAL" exp))))

;;;*****************************************************************

(define (self-evaluating? exp)
 (cond ((number? exp) true)
	   ((string? exp) true)
	   (else false)))

;;;*****************************************************************

(define (tagged-list? exp tag)
 (if (pair? exp)
  (eq? (car exp) tag)
  false))

(define (quoted? exp)
 (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

;;;*****************************************************************

(define (variable? exp) (symbol? exp))

;;;*****************************************************************

(define (assignment? exp) 
 (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

(define (eval-assignment exp env)
 (set-variable-value! (assignment-variable exp)
					  (eval (assignment-value exp) env)
					  env)
 'ok)

;;;*****************************************************************

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

;;;*****************************************************************

(define (if? exp)
 (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp) 
 (if (null? (cdddr exp))
  'false
  (cadddr exp)))

(define (make-if predicate consequent alternative)
 (list 'if predicate consequent alternative))

(define (eval-if exp env)
 (if (true? (eval (if-predicate exp) env))
  (eval (if-consequent exp) env)
  (eval (if-alternative exp) env)))

;;;*****************************************************************

(define (lambda? exp)
 (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
 (cons 'lambda (cons parameters body)))

;;;*****************************************************************

(define (begin? exp)
 (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (make-begin seq)
 (cons 'begin seq))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))

(define (last-exp? seq) (null? (cdr seq)))

;;;*****************************************************************

(define (cond? exp)
 (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
 (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (expand-clauses clauses)
 (if (null? clauses)
  'false
  (let ((first (first-exp clauses))
		(rest (rest-exps clauses)))
   (if (cond-else-clause? first)
	(if (null? rest)
	 (sequence->exp (cond-actions first))
	 (error "ELSE is not the last clause" clauses))
	(make-if (cond-predicate first)
	 (sequence->exp (cond-actions first))
	 (expand-clauses rest))))))

(define (sequence->exp exps)
 (cond ((null? exps) exps)
	   ((last-exp? exps) (first-exp exps))
	   (else (make-begin exps))))

(define (cond->if exp)
 (expand-clauses (cond-clauses exp)))

;;;*****************************************************************

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
	   (else (error "Unknown procedure -- APPLY" proc))))

(define (eval-sequence seq env)
 (cond ((last-exp? seq) (eval (first-exp seq) env))
	   (else (eval (first-exp seq) env)
		(eval-sequence (rest-exps seq) env))))

(define (list-of-values exps env)
 (if (no-operands? exps)
  '()
  (cons (eval (first-operand exps) env)
   (list-of-values (rest-operands exps) env))))

;;;*****************************************************************

(define (true? x)
 (not (eq? x false)))

(define (false? x)
 (eq? x false))

(define (compound-procedure? p) 
 (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))

(define (procedure-body p) (caddr p))

(define (procedure-env p) (cadddr p))

(define (make-procedure parameters body env)
 (list 'procedure parameters body env))

(define (primitive-procedure? p)
 (tagged-list? p 'primitive))

(define (primitive-implementation p) (cadr p))

(define primitive-procedures
 (list (list 'cons cons)
	   (list 'car car)
	   (list 'cdr cdr)
	   (list 'list list)
	   (list 'display display)
	   (list 'newline newline)
	   (list '< <)
	   (list '> >)
	   (list '= =)
	   (list 'null? null?)
	   (list '+ +)
	   (list '* *)
	   (list '- -)
	   (list '/ /)
	   (list 'eq? eq?)))

(define (primitive-procedure-names)
 (map car primitive-procedures))

(define (primitive-procedure-objects)
 (map (lambda (proc) (list 'primitive (cadr proc))) primitive-procedures))

(define (apply-primitive-procedure proc args)
 (apply (primitive-implementation proc) args))

;;;*****************************************************************

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define (make-frame variables values)
 (cons variables values))

(define (frame-variables frame) (car frame))

(define (frame-values frame) (cdr frame))

(define (lookup-variable-value var env)
 (define (env-loop env)
  (define (scan vars vals)
   (cond ((null? vars) (env-loop (enclosing-environment env)))
		 ((eq? (car vars) var) (car vals))
		 (else (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
   (error "Unbound variable -- LOOKUP" var)
   (let ((frame (first-frame env)))
	(scan (frame-variables frame)
		  (frame-values frame)))))
 (env-loop env))

(define (set-variable-value! var val env)
 (define (env-loop env)
  (define (scan vars vals)
   (cond ((null? vars) (env-loop (enclosing-environment env)))
		 ((eq? (car vars) var) (set-car! vals val))
		 (else (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
   (error "Unbound variable -- LOOKUP" var)
   (let ((frame (first-frame env)))
	(scan (frame-variables frame)
		  (frame-values frame)))))
 (env-loop env))

(define (define-variable! var val env)
 (let ((frame (first-frame env)))
  (define (scan vars vals)
   (cond ((null? vars) (add-binding-to-frame! var val frame))
		 ((eq? (car vars) var) (set-car! vals val))
		 (else (scan (cdr vars) (cdr vals)))))
  (scan (frame-variables frame)
		(frame-values frame))))

;;;*****************************************************************

(define (add-binding-to-frame! var val frame)
 (set-car! frame (cons var (car frame)))
 (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
 (if (= (length vars) (length vals))
  (cons (make-frame vars vals) base-env)
  (if (< (length vars) (length vals))
   (error "Too many variables" vars vals)
   (error "Too few variables" vars vals))))

(define (setup-environment)
 (let ((initial-env (extend-environment (primitive-procedure-names)
										(primitive-procedure-objects)
										the-empty-environment)))
  (define-variable! 'true true initial-env)
  (define-variable! 'false false initial-env)
  initial-env))

(define the-global-environment (setup-environment))

(define prompt-input ";;;M-Eval input:")
(define prompt-output ";;;M-Eval value:")

(define (prompt-for-input string)
 (newline) (newline) (display string) (newline))

(define (announce-output string)
 (newline) (display string) (newline))

(define (user-print obj)
 (if (compound-procedure? obj)
  (display (list 'compound-procedure
				 (procedure-parameters obj)
				 (procedure-body obj)
				 '<procedure-env>))
  (display obj)))

(define (driver-loop)
 (prompt-for-input prompt-input)
 (let ((input (read)))
  (let ((output (eval input the-global-environment)))
   (announce-output prompt-output)
   (user-print output)))
 (driver-loop))

(driver-loop)
