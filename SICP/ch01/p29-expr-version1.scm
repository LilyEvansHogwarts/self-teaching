(define (expr b n)
   (if (= n 0)
       1
       (* b (expr b (- n 1)))))
