(define (multi a b)
   (define (halve x) (/ x 2))
   (define (double x) (+ x x))
   (cond ((= b 0) 0)
         ((= b 1) a)
         ((even? b) (multi (double a) (halve b)))
         ((not (even? b)) (+ a (multi a (- b 1))))))
