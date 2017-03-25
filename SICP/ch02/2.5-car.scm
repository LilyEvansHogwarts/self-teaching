(define (car_ z)
   (if (= 0 (remainder z 2))
       (+ 1 (car_ (/ z 2)))
       0))
