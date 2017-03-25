(define (integral delayed-integrand initial-value dt)
  (define int (cons-stream initial-value
			   (let ((integrand (force delayed-integrand)))
			     (add-streams (scale-stream integrand dt)
					  int))))
  int)

(define (solve a b dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (add-streams (scale-stream y b)
			   (scale-stream dy a)))
  y)

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* factor x)) stream))

(define (add-streams s1 s2)
  (stream-map + s1 s2))


