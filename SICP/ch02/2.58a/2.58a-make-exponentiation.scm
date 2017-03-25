(define (make-exponentiation b e)
  (cond ((and (number? e) (= e 0)) 1)
	((and (number? e) (= e 1)) b)
	(else (list b 'expt e))))
