(define (gcd-test a b)
   (if (= b 0)
       a
       (gcd-test b (remainder a b))))
