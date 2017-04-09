(define (fixed-point proc x)
 (define (close? a b)
  (< (abs (- a b)) 0.000001))
 (if (close? (proc x) x)
  (proc x)
  (fixed-point proc (proc x))))

(define (average-damp f)
 (lambda (x) (average x (f x))))

(define (average a b)
 (/ (+ a b) 2))

(define (sqrt x)
 (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(define (cbrt x)
 (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))
