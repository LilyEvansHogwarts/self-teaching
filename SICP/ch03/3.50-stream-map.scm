(define (stream-map proc . list-of-args)
  (if (null? (car list-of-args))
    the-empty-stream
    (cons-stream (apply proc 
			(map (lambda (s) (stream-car s)) 
			     list-of-args))
		 (apply stream-map 
			(cons proc 
			      (map (lambda (s) (stream-cdr s)) 
				   list-of-args))))))
