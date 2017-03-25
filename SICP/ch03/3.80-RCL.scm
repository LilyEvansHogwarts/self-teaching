(define (RCL R L C dt)
  (lambda (vC0 iL0)
    (define iL (integral (delay (scale-stream vL (/ 1 L))) iL0 dt))
    (define vC (integral (delay (scale-stream iL (/ -1 C))) vC0 dt))
    (define vL (sub-streams vC (scale-stream iL R)))
    (stream-map (lambda (x y) (list x y)) iL vC)))

(define (integral delayed-integrand initial-value dt)
  (define int 
    (cons-stream initial-value
		 (let ((integrand (force delayed-integrand)))
		   (add-streams (scale-stream integrand dt)
				int))))
  int)

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (sub-streams s1 s2)
  (stream-map - s1 s2))

(define circuit
  ((RCL 1 0.2 1 0.1) 10 0))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show circuit) n))


