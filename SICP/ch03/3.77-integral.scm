(define (integral delayed-integrand initial-value dt)
  (cons-stream initial-value
	       (let ((integrand (force delayed-integrand)))
		 (if (stream-null? integrand)
		   the-empty-stream
		   (integral (delay (stream-cdr integrand))
			     (+ (* dt (stream-car integrand))
				initial-value)
			     dt)))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

(define e1
  (stream-ref (solve (lambda (x) x) 1 0.001) 1000))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define q (cons-stream 1 (mul-streams (stream-map (lambda (x) (/ 1.0 x)) integers)
				      q)))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define (partial-sums stream)
  (define sums (cons-stream (stream-car stream)
			    (add-streams (stream-cdr stream)
					 sums)))
  sums)

(define (e2 n)
  (stream-ref (partial-sums q) n))

