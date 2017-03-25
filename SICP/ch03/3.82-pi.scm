(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo stream passed failed)
  (define (next passed failed)
    (cons-stream (/ passed (+ passed failed))
		 (monte-carlo (stream-cdr stream) passed failed)))
  (if (stream-car stream)
    (next (+ passed 1) failed)
    (next passed (+ failed 1))))

(define (in-area x)
  (let ((key (+ (square (- (car x) 5))
		(square (- (cadr x) 7)))))
    (<= key 9.0)))

(define (pairs low1 high1 low2 high2)
  (cons-stream (list (random-in-range low1 high1) (random-in-range low2 high2))
	       (pairs low1 high1 low2 high2)))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (pi-stream f low1 high1 low2 high2)
  (let ((pairs-stream (pairs low1 high1 low2 high2)))
    (scale-stream (monte-carlo (stream-map f pairs-stream) 0 0) 4.0)))

(define pi (pi-stream in-area 2.0 8.0 4.0 10.0))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show pi) n))
