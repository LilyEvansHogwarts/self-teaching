(define (ambeval exp env succeed fail)
 ((analyze exp) env succeed fail))

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
	   ((amb? exp)
		(analyze-amb exp))
	   ((application? exp)
		(analyze-application exp))
	   (else (error "Unknown operation -- EVAL" exp))))

;;;***********************************************************************

(define (self-evaluating? exp)
 (cond ((number? exp) true)
	   ((string? exp) true)
	   (else false)))

(define (analyze-self-evaluating exp)
 (lambda (env succeed fail)
  (succeed exp fail)))

;;;***********************************************************************

(define (tagged-list? exp tag)
 (if (pair? exp)
  (eq? (car exp) tag)
  false))

(define (quoted? exp) (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

(define (analyze-quoted exp)
 (let ((qval (text-of-quotation exp)))
  (lambda (env succeed fail)
   (succeed qval fail))))

;;;***********************************************************************

(define (variable? exp) (symbol? exp))

(define (analyze-variable exp)
 (lambda (env succeed fail)
  (succeed (lookup-variable-value exp env) fail)))

;;;***********************************************************************

(define (assignment? exp) (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

(define (analyze-assignment exp)
 (let ((var (assignment-variable exp))
	   (bproc (analyze (assignment-value exp))))
  (lambda (env succeed fail)
   (vproc env
	(lambda (val fail2)
	 (let ((old-value (lookup-variable-value var env)))
	  (set-variable-value! var val env)
	  (succeed 'ok
	   (lambda ()
		(set-variable-value! var old-value env)
		(fail2)))))
	fail))))

;;;***********************************************************************

(define (definition? exp) (tagged-list? exp 'define))

(define (definition-variable exp) 
 (if (symbol? (cadr exp))
  (cadr exp)
  (caadr exp)))

(define (definition-value exp)
 (if (symbol? (cadr exp))
  (caddr exp)
  (make-lambda (cdadr exp) (cddr exp))))

(define (analyze-definition exp)
 (let ((var (definition-variable exp))
	   (bproc (analyze (definition-value exp))))
  (lambda (env succeed fail)
   (bproc env
	(lambda (val fail2) 
	 (define-variable! var val env)
	 (succeed 'ok fail2))
	fail))))

;;;***********************************************************************

(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
 (if (null? (cdddr exp))
  'false
  (cadddr exp)))

(define (make-if predicate consequent alternative)
 (list 'if predicate consequent alternative))

(define (analyze-if exp)
 (let ((pproc (analyze (if-predicate exp)))
	   (cproc (analyze (if-consequent exp)))
	   (aproc (analyze (if-alternative exp))))
  (lambda (env succeed fail)
   (pproc env
	(lambda (pred-value fail2)
	 (if (true? pred-value)
	  (cproc env succeed fail2)
	  (aproc env succeed fail2)))
	fail))))

(define (true? x)
 (not (eq? x false)))

(define (false? x)
 (eq? x false))

;;;***********************************************************************

(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
 (cons 'lambda (cons parameters body)))

(define (analyze-lambda exp)
 (let ((vars (lambda-parameters exp))
	   (bproc (analyze-sequence (lambda-body exp))))
  (lambda (env succeed fail)
   (succeed (make-procedure vars bproc env) fail))))

(define (analyze-sequence exps)
 (define (sequentially a b)
  (lambda (env succeed fail)
   (a env
	(lambda (a-value fail2)
	 (b env succeed fail2))
	fail)))
 (define (loop first-proc rest-procs)
  (if (null? rest-procs)
   first-proc
   (loop (sequentially first-proc (car rest-procs))
	(cdr rest-procs))))
 (let ((procs (map analyze exps)))
  (if (null? procs)
   (error "Empty sequence -- ANALYZE-SEQUENCE")
   (loop (car procs) (cdr procs)))))

;;;***********************************************************************

(define (begin? exp) (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (make-begin seq) (cons 'begin seq))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))

(define (last-exp? seq) (null? (cdr seq)))

(define (sequence->exp seq)
 (cond ((null? seq) seq)
	   ((last-exp? seq) (first-exp seq))
	   (else (make-begin seq))))

;;;***********************************************************************

(define (cond? exp) (tagged-list? exp 'cond))

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

;;;***********************************************************************

(define (amb? exp) (tagged-list? exp 'amb))

(define (amb-choices exp) (cdr exp))

(define (analyze-amb exp)
 (let ((cprocs (map analyze (amb-choices exp))))
  (lambda (env succeed fail)
   (define (try-next choices)
	(if (null? choices)
	 (fail)
	 ((car choices) env
	  succeed
	  (lambda ()
	   (try-next (cdr choices))))))
   (try-next cprocs))))

;;;***********************************************************************

(define (application? exp) (pair? exp))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (analyze-application exp)
 (let ((fproc (analyze (operator exp)))
	   (aprocs (map analyze (operands exp))))
  (lambda (env succeed fail)
   (fproc env
	(lambda (proc fail2)
	 (get-args aprocs
	  env
	  (lambda (args fail3)
	   (execute-application proc args succeed fail3))
	  fail2))
	fail))))

(define (get-args aprocs env succeed fail)
 (if (null? aprocs)
  (succeed '() fail)
  ((car aprocs) env
   (lambda (arg fail2)
	(get-args (cdr aprocs)
	 env
	 (lambda (args fail3)
	  (succeed (cons arg args) fail3))
	 fail2))
   fail)))

(define (execute-application proc args succeed fail)
 (cond ((primitive-procedure? proc)
		(succeed (apply-primitive-procedure proc args) fail))
	   ((compound-procedure? proc)
		((procedure-body proc)
		 (extend-environment (procedure-parameters proc)
							 args
							 (procedure-env proc))
		 succeed
		 fail))
	   (else (error "Unknown procedure type -- EXECUTE-APPLICATION" proc))))

;;;***********************************************************************

(define (primitive-procedure? p) (tagged-list? p 'primitive))

(define (primitive-implementation p) (cadr p))

(define primitive-procedures
 (list (list 'cons cons)
	   (list 'car car)
	   (list 'cdr cdr)
	   (list 'null? null?)
	   (list 'eq? eq?)
	   (list 'not not)
	   (list 'list list)
	   (list 'memq memq)
	   (list '* *)
	   (list '- -)
	   (list '/ /)
	   (list '+ +)
	   (list '< <)
	   (list '> >)
	   (list '<= <=)
	   (list '>= >=)))

(define (primitive-procedure-names)
 (map car primitive-procedures))

(define (primitive-procedure-objects)
 (map (lambda (proc) (list 'primitive (cadr proc))) primitive-procedures))

(define (apply-primitive-procedure proc args)
 (apply (primitive-implementation proc) args))

(define (compound-procedure? p) (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))

(define (procedure-body p) (caddr p))

(define (procedure-env p) (cadddr p))

(define (make-procedure parameters body env)
 (list 'procedure parameters body env))

;;;***********************************************************************

(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define (make-frame variables values)
 (cons variables values))

(define (frame-variables frame) (car frame))

(define (frame-values frame) (cdr frame))

(define the-empty-environment '())

(define (add-binding-to-frame! var val frame)
 (set-car! frame (cons var (car frame)))
 (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
 (if (= (length vars) (length vals))
  (cons (make-frame vars vals) base-env)
  (if (< (length vars) (length vals))
   (error "Too many variables" vars vals)
   (error "Too few variables" vars vals))))

(define (scan vars vals var)
 (cond ((null? vars) false)
       ((eq? (car vars) var) vals)
	   (else (scan (cdr vars) (cdr vals) var))))

(define (lookup-variable-value var env)
 (define (env-loop env)
  (if (eq? env the-empty-environment)
   (error "Unbound variable -- lookup" var)
   (let ((frame (first-frame env)))
	(let ((vals (scan (frame-variables frame) (frame-values frame) var)))
	 (if vals
	  (car vals)
	  (env-loop (enclosing-environment env)))))))
 (env-loop env))

(define (set-variable-value! var val env)
 (define (env-loop env)
  (if (eq? env the-empty-environment)
   (error "Unbound variable -- set!" var)
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

(define (setup-environment)
 (let ((initial-env (extend-environment (primitive-procedure-names)
										(primitive-procedure-objects)
										the-empty-environment)))
  (define-variable! 'true true initial-env)
  (define-variable! 'false false initial-env)
  initial-env))

(define the-global-environment (setup-environment))

;;;***********************************************************************

(define input-prompt ";;;Amb-Eval input:")
(define output-prompt ";;;Amb-Eval value:")

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
 (define (internal-loop try-again)
  (prompt-for-input input-prompt)
  (let ((input (read)))
   (if (eq? input 'try-again)
	(try-again)
	(begin (newline)
	 (display ";;;Starting a new problem ")
	 (ambeval input 
	  the-global-environment
	  (lambda (val next-alternative)
	   (announce-output output-prompt)
	   (user-print val)
	   (internal-loop next-alternative))
	  (lambda ()
	   (announce-output ";;;There are no more values of")
	   (user-print input)
	   (driver-loop)))))))
 (internal-loop
  (lambda ()
   (newline)
   (display ";;;There is no current problem")
   (driver-loop))))

(driver-loop)
