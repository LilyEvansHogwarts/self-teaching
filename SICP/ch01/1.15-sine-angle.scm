(define (sine x)
   (define (cube y) (* y y y))
   (if (< (abs x) 0.1)
       x
       (- (* 3 (sine (/ x 3))) (* 4 (cube (sine (/ x 3)))))))
