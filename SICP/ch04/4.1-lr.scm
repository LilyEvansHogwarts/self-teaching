(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((left (eval (first-operand exps) env))
	  (right (list-of-values (rest-operands exps) env)))
      (cons left right))))

