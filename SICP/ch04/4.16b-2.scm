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
