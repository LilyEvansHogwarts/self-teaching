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

