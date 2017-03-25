(load "1.37-cont-frac.scm")
  
(define (iter-cont-frac k)
   (define (d i) 1.0)
   (define (n i) 1.0)
   (cont-frac d n k))
