(load "1.46-fixed-point.scm")

(define (sqrt_ x)
   (fixed-point (lambda (y) (/ (+ y (/ x y)) 2)) 1.0))
