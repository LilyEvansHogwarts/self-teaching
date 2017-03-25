(load "1.46-iterative-improve.scm")

(define (fixed-point f first-guess)
   (define (close-enough? v1 v2) (< (abs (- v1 v2)) 0.00001))
   ((iterative-improve close-enough? f) first-guess))
