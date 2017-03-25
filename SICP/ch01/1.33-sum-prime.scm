(load "1.33-filter2.scm")

(define (sum-prime a b)
   (define (next n) (+ n 1))
   (define (term n) n)
   (define (prime? n)
      (= (smallest-divisor n) n))
   (define (smallest-divisor n)
      (find-divisor n 2))
   (define (find-divisor n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? n test-divisor) test-divisor)
            (else (find-divisor n (next-odd test-divisor)))))
   (define (divides? n test-divisor)
      (= (remainder n test-divisor) 0))
   (define (next-odd n)
      (if (odd? n)
          (+ n 2)
          (+ n 1)))
   (define (combiner x y) (+ x y))
   (filtered prime? combiner 0 term a next b))
     
