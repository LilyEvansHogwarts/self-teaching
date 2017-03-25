(define (repeated f n)
   (lambda (x) (if (= 0 n)
                   x
                   ((repeated f (- n 1)) (f x)))))
