;;;Alyssa想象中的analyze-sequence
	
(define (analyze-sequence exps)
 (define (execute-sequence procs env)
  (cond ((null? (cdr procs)) ((car procs) env))
   (else ((car procs) env)
		 (execute-sequence (cdr procs) env))))
 (let ((procs (map analyze exps)))
  (if (null? procs)
   (error "Empty sequence -- ANALYZE"))
  (lambda (env) (execute-sequence procs env))))

;;;实际运行:
;;;(e1)
;;;(lambda (env)
;;;  (execute-sequence ((analyze e1)) env))
;;;
;;;(e1 e2)
;;;(lambda (env)
;;;  (execute-sequence ((analyze e1) (analyze e2)) env))
;;;
;;;(e1 e2 e3)
;;;(lambda (env)
;;;  (execute-sequence ((analyze e1) (analyze e2) (analyze e3)) env))

;;;原本的analyze-sequence

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
   (error "Empty sequence -- ANALYZE"))
  (loop (car procs) (cdr procs))))

;;;实际运行:
;;;(e1)
;;;(lambda (env)
;;;  ((analyze e1) env))
;;;
;;;(e1 e2)
;;;(lambda (env)
;;;  ((analyze e1) env)
;;;  ((analyze e2) env))
;;; 
;;;(e1 e2 e3)
;;;(lambda (env)
;;;  ((lambda (env)
;;;     ((analyze e1) env)
;;;     ((analyze e2) env))
;;;    env)
;;;  ((analyze e3) env))

;;;通过上述可知，Alyssa想象中的analyze-sequence并不能达到analyze函数的作用，无法简化运算过程
