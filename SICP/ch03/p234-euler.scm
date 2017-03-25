(define (odd-starting-from n)
  (if (odd? n)
    (cons-stream (- (* 2 n) 1) (odd-starting-from (+ n 1)))
    (cons-stream (- 1 (* 2 n)) (odd-starting-from (+ n 1)))))

(define odd-stream
  (stream-map (lambda (s) (/ 1 s)) (odd-starting-from 1)))

(define (partial-sums stream)
  (define sums (cons-stream (stream-car stream)
			    (add-streams sums
					 (stream-cdr stream))))
  sums)

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (s) (* s factor)) stream))

(define pi (scale-stream (partial-sums odd-stream) 4.0))

(define (euler-transformer s)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1))
	(s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1)) (+ s0 (* -2 s1) s2)))
		 (euler-transformer (stream-cdr s)))))

(define new-pi (euler-transformer pi))

(define (make-tableau transformer s)
  (cons-stream s
	       (make-tableau transformer (transformer s))))

(define (accelerated-sequence transformer s)
  (stream-map stream-car (make-tableau transformer s)))

(define acc-pi (accelerated-sequence euler-transformer pi))
