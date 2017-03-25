(define one (cons-stream 10000000 one))

(define random-numbers 
  (stream-map random one))

(define (map-successive-pairs f stream)
  (cons-stream
    (f (stream-car stream) (stream-car (stream-cdr stream)))
    (map-successive-pairs f (stream-cdr (stream-cdr stream)))))

(define cesaro-stream
  (map-successive-pairs (lambda (s1 s2) (= (gcd s1 s2) 1)) random-numbers))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream (/ passed (+ passed failed))
		 (monte-carlo (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
    (next (+ passed 1) failed)
    (next passed (+ failed 1))))

(define pi (stream-map (lambda (x) (sqrt (/ 6 x)))
		       (monte-carlo cesaro-stream 0 0)))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show pi) n))
