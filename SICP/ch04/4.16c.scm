(define (make-let bindings body)
 (list 'let bindings body))

(define (scan-out-defines body)
 (let* ((definitions (filter (lambda (x) (definition? x)) body))
		(non-definitions (filter (lambda (x) (not (definition? x))) body))
		(let-vars (map definition-variable definitions))
		(let-vals (map definition-value definitions))
		(let-bindings (map (lambda (x) (list x '*unassigned*)) let-vars))
		(let-body (map (lambda (x y) (list 'set! x y)) let-vars let-vals)))
  (if (null? let-bindings)
   body
   (list (make-let let-bindings (append let-body non-definitions))))))

(define (make-procedure parameters body env)
 (list 'procedure parameters (scan-out-defines body) env))

 (define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars) (env-loop (enclosing-environment env)))
	    ((eq? var (car vars)) 
		 (if (eq? '*unassigned* (car vals))
		  (error "the variable is unassigned -- LOOKUP" var)
		  (car vals)))
	    (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
	(scan (frame-variables frame)
	      (frame-values frame)))))
  (env-loop env))

;;;这里选择将scan-out-defines安装在make-procedure中，因为如果选择安装在procedure-body中，会每次使用procedure-body的时候都要重新计算scan-out-defines
