(load "1.37-cont-frac.scm")

(define (tan_ x k)
   (define (n i) 
      (if (= i 1)
          x
          (- (square x))))
   (define (d i) (- (* 2 i) 1))
   (cont-frac n d k))
