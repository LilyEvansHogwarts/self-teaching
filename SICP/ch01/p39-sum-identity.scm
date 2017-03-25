(load "p38-high-order-sum.scm")

(define (sum-identity a b)
   (define (inc n) (+ n 1))
   (define (identity x) x)
   (sum identity a inc b))
