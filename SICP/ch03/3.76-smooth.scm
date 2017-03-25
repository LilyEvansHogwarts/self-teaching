(define (smooth stream)
  (if (stream-null? (stream-cdr stream))
    the-empty-stream
    (let ((s1 (stream-car stream))
	  (s2 (stream-car (stream-cdr stream))))
      (cons-stream (/ (+ s1 s2) 2)
		   (smooth (stream-cdr stream))))))

(define (make-zero-crossing input-stream last-value)
  (cons-stream 
    (sign-change-detector (stream-car input-stream) last-value)
    (make-zero-crossing (stream-cdr input-stream)
			(stream-car input-stream))))

(define (sign-change-detector a b)
  (cond ((or (and (>= a 0) (>= b 0))
	     (and (< a 0) (< b 0)))
	 0)
	((and (>= a 0) (< b 0)) 1)
	(else -1)))

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

(define zero-crossing (make-zero-crossing (smooth sense-data) 0))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show zero-crossing) n))
