(load "1.32-accumulate2.scm")

(define (sum a b)
   (define (combiner x y) (+ x y))
   (define (term n) n)
   (define (next n) (+ n 1))
   (accumulate combiner 0 term a next b))
