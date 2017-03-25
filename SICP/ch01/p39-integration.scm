(load "p38-high-order-sum.scm")
(define (integration f a b dx)
   (define (add-dx x) (+ x dx))
   (* (sum f (+ a (/ dx 2)) add-dx b) dx))
