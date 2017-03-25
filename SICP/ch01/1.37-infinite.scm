(load "p46-fixed-point2.scm")
 
(define (cont-frac n d)
   (define (infinite-continued-fraction x) (+ d (/ n x)))
   (fixed-point infinite-continued-fraction 1.0))
      
