(load "p38-high-order-sum.scm")

(define (pi-sum a b)
   (define (pi-term n) (/ 1 (* n (+ n 2))))
   (define (inc n) (+ n 4))
   (sum pi-term a inc b))
