(define (expr a b)
 (define (expr-iter result a b)
  (if (= b 0)
   result
   (if (odd? b)
	(expr-iter (* result a) a (- b 1))
	(expr-iter result (* a a) (/ b 2)))))
 (expr-iter 1.0 a b))
