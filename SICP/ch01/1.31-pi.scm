(load "1.31-product1.scm")

(define (pi a b)
   (define (pre-even n) 
      (if (even? n)
          n
          (- n 1)))
   (define (next-even n)
      (if (even? n)
          n
          (+ n 1)))
   (define (pre-odd n)
      (- (pre-even n) 1))
   (define (next-odd n)
      (+ (next-even n) 1))
   (define (term n) 
      (cond ((= n (next-even a)) n)
            ((= n (pre-even b)) n) 
            (else (* n n))))
   (define (next n) (+ n 2))
   (/ (product term (next-even a) next (pre-even b)) (product term (next-odd a) next (pre-odd b))))