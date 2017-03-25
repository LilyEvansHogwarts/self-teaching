(define (make-zero-crossing input-stream v1 v2)
  (let ((s1 (/ (+ v1 v2) 2))
	(s2 (/ (+ (stream-car input-stream) v1) 2)))
    (cons-stream (sign-change-detector s2 s1)
		 (make-zero-crossing (stream-cdr input-stream)
				     s2 
				     s1))))

(define (sign-change-detector a b)
  (cond ((or (and (>= a 0) (>= b 0))
	     (and (< a 0) (< b 0))) 
	 0)
	((and (<= a 0) (> b 0)) -1)
	(else 1)))

(define sense-data (cons-stream 1 
				(cons-stream 2 
					     (cons-stream 1.5 
							  (cons-stream 1 
								       (cons-stream 0.5 
										    (cons-stream -0.1 
												 (cons-stream -2
													      (cons-stream -3
															   (cons-stream -2
																	(cons-stream -0.5 
																		     (cons-stream 0.2 
																				  (cons-stream 3
																					       (cons-stream 4 the-empty-stream))))))))))))))

(define zero-crossing (make-zero-crossing (stream-cdr sense-data) (stream-car sense-data) 0))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show zero-crossing) n))
