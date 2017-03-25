(load "1.33-filter2.scm")

(define (mul-gcd a b)
   (define (term n) n)
   (define (next n) (+ n 1))
   (define (combiner x y) (* x y))
   (define (gcd_ n m)
      (let ((r (remainder n m)))
         (cond ((= r 1) #t)
               ((= r 0) #f)
               (else (gcd_ m r)))))
   (define (test n)
      (gcd_ b n))
   (filtered test combiner 1 term a next b))
            
      
