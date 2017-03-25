;exercise 1.3
(define (max_sum a b c) 
   (if (> a b)
       (if (> c b)
           (+ a c)
           (+ a b))
       (if (> c a)
           (+ b c)
           (+ b a))))
