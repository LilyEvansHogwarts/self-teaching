(load "p38-high-order-sum.scm")

(define (sum-cubes a b)
   (define (inc n) (+ n 1))
   (define (cube x) (* x x x))
   (sum cube a inc b))
