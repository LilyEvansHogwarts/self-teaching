(define (integers-starting-from n)
  (if (odd? n)
    (cons-stream n (integers-starting-from (+ n 1)))
    (cons-stream (- n) (integers-starting-from (+ n 1)))))


(define integers (integers-starting-from 1))

(define q1 (stream-map (lambda (s) (/ 1 s)) integers))

(define (euler-transformer stream)
  (let ((s0 (stream-ref stream 0))
	(s1 (stream-ref stream 1))
	(s2 (stream-ref stream 2)))
    (cons-stream (- s2 (/ (square (- s2 s1)) (+ s0 (* -2 s1) s2)))
		 (euler-transformer (stream-cdr stream)))))

(define (make-tableau transformer s)
  (cons-stream s
	       (make-tableau transformer (transformer s))))

(define (accelerated-sequence transformer s)
  (stream-map stream-car (make-tableau transformer s)))

(define (partial-sums stream)
  (define sumup (cons-stream (stream-car stream)
			     (add-streams sumup (stream-cdr stream))))
  sumup)

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map stream-car args))
		 (apply stream-map (cons proc (map stream-cdr args))))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream stream factor) 
  (stream-map (lambda (s) (* s factor)) stream))

(define s1 (scale-stream (partial-sums q1) 1.0))

(define s2 (scale-stream (euler-transformer s1) 1.0))

(define s3 (scale-stream (accelerated-sequence euler-transformer s1) 1.0))

(define (show x)
  (newline)
  (display x)
  x)

(define (show-s1 n)
  (stream-ref (stream-map show s1) n))

(define (show-s2 n)
  (stream-ref (stream-map show s2) n))

(define (show-s3 n)
  (stream-ref (stream-map show s3) n))
