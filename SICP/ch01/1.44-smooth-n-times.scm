(load "1.43-repeated.scm")
(load "1.44-smooth.scm")

(define (smooth-n-times f n)
   ((repeated smooth n) f)) 
