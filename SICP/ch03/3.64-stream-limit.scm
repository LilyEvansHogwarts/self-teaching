(define (stream-limit stream tolerance)
  (let ((s1 (stream-car stream))
	(s2 (stream-car (stream-cdr stream))))
    (if (> tolerance (abs (- s1 s2)))
      s2
      (stream-limit (stream-cdr stream) tolerance))))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (average a b)
  (/ (+ a b) 2))

(define (sqrt-stream x)
  (define guesses (cons-stream 1.0 (stream-map (lambda (guess)
						 (sqrt-improve guess x))
					       guesses)))
  guesses)

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
