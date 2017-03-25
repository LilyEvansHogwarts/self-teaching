(load "1.31-product2.scm")

(define (factorial a)
   (define (term n) n)
   (define (next n) (+ n 1))
   (product term 1 next a))
