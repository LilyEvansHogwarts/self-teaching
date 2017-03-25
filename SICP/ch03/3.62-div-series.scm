(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
	       (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
			    (mul-series (stream-cdr s1) s2))))

(define (reciprocal S)
  (define Sr (stream-cdr S))
  (define X (cons-stream 1 (mul-series (scale-stream Sr -1) X)))
  X)

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (s) (* s factor)) stream))

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
    (error "the first item of s2 is 0" (stream-car s2))
    (let ((s (scale-stream s2 (/ 1 (stream-car s2)))))
      (let ((r (scale-stream (reciprocal s) (stream-car s2))))
	(mul-series s1 r)))))
