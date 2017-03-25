(define (cdr_ z)
   (if (= 0 (remainder z 3))
       (+ 1 (cdr_ (/ z 3)))
       0))
