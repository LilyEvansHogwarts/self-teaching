(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define s (cons-stream 1 (add-streams s s)))
