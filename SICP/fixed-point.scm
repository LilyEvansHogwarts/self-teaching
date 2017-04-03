(define (fixed-point proc x)
 (define (close? a b)
  (< (abs (- a b)) 0.000001))
 (if (close? (proc x) x)
  (proc x)
  (fixed-point proc (proc x))))

(define (sqrt-root x)
 (fixed-point (lambda (y) (/ (+ y (/ x y)) 2)) 1.0))
