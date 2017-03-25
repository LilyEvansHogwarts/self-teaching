(load "p46-fixed-point2.scm")

(define (gold-section n)
   (fixed-point (lambda (x) (+ 1 (/ 1 x))) n))
