(define (sum-cubes a b)
   (define (cube x) (* x x x))
   (if (> a b)
       0
       (+ (cube a) (sum-cubes (+ a 1) b))))
