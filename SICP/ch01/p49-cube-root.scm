(load "p46-fixed-point2.scm")

(define (cube-root x)
   (define (average-damp f) (lambda (x) (/ (+ x (f x)) 2)))
   (fixed-point (average-damp (lambda (y) (/ x (square y)))) 1.0))
