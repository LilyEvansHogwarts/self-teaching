(load "p38-high-order-sum.scm")

(define (integration f a b dx)
   (* (sum f 
        (+ a (/ dx 2)) 
        (lambda (y) (+ y dx))
        b) 
      dx))
