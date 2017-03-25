(load "p46-fixed-point.scm")

(define (sqrt_ x)
   (define (average x y) (/ (+ x y) 2))
   (fixed-point (lambda (y) (average y (/ x y))) 0.2))
