(load "1.46-fixed-point.scm")

(define (cube-root x)
   (fixed-point (lambda (y) (/ (+ y (/ x (square y))) 2)) 1.0))
