(load "1.32-accumulate2.scm")

(define (product a b)
   (define (combiner x y) (* x y))
   (define (term n) n)
   (define (next n) (+ n 1))
   (accumulate combiner 1 term a next b))
