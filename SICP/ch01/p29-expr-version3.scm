(define (fast-expr b n)
   (cond ((= n 0) 1)
       ((even? n) (square (fast-expr b (/ n 2))))
       ((not (even? n)) (* b (square (fast-expr b (/ (- n 1) 2)))))))
