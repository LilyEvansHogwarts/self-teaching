(load "p50-fixed-point-of-transform.scm")

(define (cubic a b c guess)
   (define (cubic-function x) (+ (* x x x) (* a x x) (* b x) c))
   (fixed-point-of-transform cubic-function guess))
   
