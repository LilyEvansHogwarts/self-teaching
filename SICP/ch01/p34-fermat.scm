(define (fast-prime? n times)
   (define (fermat-test n)
      (try-it (+ 1 (random (- n 1)))))
   (define (try-it a)
         (= (expmod a n n) a))
   (define (expmod base exp_ m)
      (cond ((= exp_ 0) 1)
            ((even? exp_) (remainder (square (expmod base (/ exp_ 2) m)) m))
            (else (remainder (* base (expmod base (- exp_ 1) m)) m))))
   (cond ((= times 0) true)
         ((fermat-test n) (fast-prime? n (- times 1)))
         (else false)))
