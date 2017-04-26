(define (eval exp env)
 ((analyze exp) env))

(define (analyze exp)
 (cond ((self-evaluating? exp) 
		(analyze-self-evaluating exp))
	   ((quoted? exp)
		(analyze-quoted exp))
	   ((variable? exp)
		(analyze-variable exp))
	   ((assignment? exp)
		(analyze-assignment exp))
	   ((definition? exp)
		(analyze-definition exp))
	   ((if? exp)
		(analyze-if exp))
	   ((lambda? exp)
		(analyze-lambda exp))
	   ((begin? exp)
		(analyze-sequence (begin-actions exp)))
	   ((cond? exp)
		(analyze (cond->if exp)))
	   ((application? exp)
		(analyze-application exp))
	   (else (error "Unknown operation -- ANALYZE" exp))))

;;;**********************************************************************

(define (self-evaluating? exp)
 (cond ((number? exp) true)
	   ((string? exp) true)
	   (else false)))

(define (analyze-self-evaluating exp)
 (lambda (env) exp))

;;;**********************************************************************

(define (tagged-list? exp tag)
 (if (pair? exp)
  (eq? (car exp) tag)
  false))

(define (quoted? exp)
 (tagged-list? exp 'quote))

(define (analyze-quoted exp)
 (let ((qval (text-of-quotation exp)))
  (lambda (env) qval)))

(define (text-of-quotation exp) (cadr exp))

;;;**********************************************************************

(define (variable? exp) (symbol? exp))

(define (analyze-variable exp)
 (lambda (env) (lookup-variable-value exp env)))

;;;**********************************************************************

(define (assignment? exp)
 (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

(define (analyze-assignment exp)
 (let ((avar (assignment-variable exp))
	   (aval (analyze (assignment-value exp))))
  (lambda (env)
   (set-variable-value! avar (aval env) env)
   'ok)))

;;;**********************************************************************

(define (definition? exp)
 (tagged-list? exp 'define))

(define (definition-variable exp)
 (if (symbol? (cadr exp))
  (cadr exp)
  (caadr exp)))

(define (definition-value exp)
 (if (symbol? (cadr exp))
  (caddr exp)
  (make-lambda (cdadr exp) (cddr exp))))

(define (analyze-definition exp)
 (let ((dvar (definition-variable exp))
	   (dval (analyze (definition-value exp))))
  (lambda (env)
   (define-variable! dvar (dval env) env)
   'ok)))

;;;**********************************************************************

(define (if? exp)
 (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp) (cadddr exp))

(define (make-if predicate consequent alternative)
 (list 'if predicate consequent alternative))

(define (analyze-if exp)
 (let ((pproc (analyze (if-predicate exp)))
	   (cproc (analyze (if-consequent exp)))
	   (aproc (analyze (if-alternative exp))))
  (lambda (env)
   (if (true? (pproc env))
	(cproc env)
	(aproc env)))))

(define (true? x)
 (not (eq? x false)))

(define (false? x)
 (eq? x false))

;;;**********************************************************************

(define (lambda? exp)
 (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
 (cons 'lambda (cons parameters body)))

(define (analyze-lambda exp)
 (let ((para (lambda-parameters exp))
	   (bproc (analyze-sequence (lambda-body exp))))
  (lambda (env)
   (make-procedure para bproc env))))

(define (analyze-sequence exps)
 (define (sequentially proc1 proc2)
  (lambda (env) (proc1 env) (proc2 env)))
 (define (loop first-proc rest-procs)
  (if (null? rest-procs)
   first-proc
   (loop (sequentially first-proc (car rest-procs))
		 (cdr rest-procs))))
 (let ((procs (map analyze exps)))
  (if (null? procs)
   '()
   (loop (car procs) (cdr procs)))))

;;;**********************************************************************

(define (begin? exp)
 (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (make-begin exps)
 (cons 'begin exps))

;;;**********************************************************************

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

(define (cond->if exp)
 (expand-clauses (cond-clauses exp)))

(define (first-exp exps) (car exps))

(define (rest-exps exps) (cdr exps))

(define (last-exp? exps) (null? (cdr exps)))

(define (sequence->exp exps)
 (cond ((last-exp? exps) (first-exp exps))
  (else (make-begin exps))))

;;;**********************************************************************

(define (application? exp) (pair? exp))

(define (analyze-application exp)
 (let ((fproc (analyze (operator exp)))
	   (aprocs (map analyze (operands exp))))
  (lambda (env)
   (execute-application (fproc env) (map (lambda (aproc) (aproc env)) aprocs)))))

(define (execute-application proc args)
 (cond ((primitive-procedure? proc)
		(apply-primitive-procedure proc args))
	   ((compound-procedure? proc)
		((procedure-body proc)
		 (extend-environment (procedure-parameters proc)
		                     args
							 (procedure-env proc))))
	   (else (error "Unknown procedure type -- APPLICATION" proc))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

;;;**********************************************************************

(define (primitive-procedure? p)
 (tagged-list? p 'primitive))

(define (primitive-implementation p) (cadr p))

(define primitive-procedures
 (list (list 'cons cons)
       (list 'car car)
	   (list 'cdr cdr)
	   (list 'null? null?)
	   (list 'eq? eq?)
	   (list 'list list)
	   (list 'display display)
	   (list 'newline newline)
	   (list '< <)
	   (list '> >)
	   (list '>= >=)
	   (list '<= <=)
	   (list '+ +)
	   (list '- -)
	   (list '/ /)
	   (list '* *)))

(define (primitive-procedure-names)
 (map car primitive-procedures))

(define (primitive-procedure-objects)
 (map (lambda (proc) (list 'primitive (cadr proc))) primitive-procedures))

(define (compound-procedure? p) 
 (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))

(define (procedure-body p) (caddr p))

(define (procedure-env p) (cadddr p))

(define (make-procedure parameters body env)
 (list 'procedure parameters body env))

(define (apply-primitive-procedure proc args)
 (apply (primitive-implementation proc) args))

;;;**********************************************************************

(define (scan vars vals var)
 (cond ((null? vars) false)
       ((eq? (car vars) var) vals)
	   (else (scan (cdr vars) (cdr vals) var))))

(define (lookup-variable-value var env)
 (define (env-loop env)
  (if (eq? env the-empty-environment)
   (error "Unbound variable" var)
   (let ((frame (first-frame env)))
	(let ((vals (scan (frame-variables frame) (frame-values frame) var)))
	 (if vals
	  (car vals)
	  (env-loop (enclosing-environment env)))))))
 (env-loop env))

(define (set-variable-value! var val env)
 (define (env-loop env)
  (if (eq? env the-empty-environment)
   (error "Unbound variable" var)
   (let ((frame (first-frame env)))
	(let ((vals (scan (frame-variables frame) (frame-values frame) var)))
	 (if vals
	  (set-car! vals val)
	  (env-loop (enclosing-environment env)))))))
 (env-loop env))

(define (define-variable! var val env)
 (let ((frame (first-frame env)))
  (let ((vals (scan (frame-variables frame) (frame-values frame) var)))
   (if vals
	(set-car! vals val)
	(add-binding-to-frame! var val frame)))))

;;;**********************************************************************

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define (make-frame variables values)
 (cons variables values))

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

(define the-empty-environment '())

(define (setup-environment)
 (let ((initial-env (extend-environment (primitive-procedure-names)
										(primitive-procedure-objects)
										the-empty-environment)))
  (define-variable! 'true true initial-env)
  (define-variable! 'false false initial-env)
  initial-env))

(define the-global-environment (setup-environment))

(define prompt-input ";;;Analyze-Eval input:")
(define prompt-output ";;;Analyze-Eval value:")

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

(define (interpret exp)
 (eval exp the-global-environment))
