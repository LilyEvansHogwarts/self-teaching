(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sums integers)
  (cons-stream (stream-car integers) (add-streams (stream-cdr integers) (partial-sums integers))))
