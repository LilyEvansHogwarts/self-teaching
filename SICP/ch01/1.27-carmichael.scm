(define (prime? n) 
   (define (fast-prime? n times)
      (cond ((= times 0) #t)
            ((fermat-test n) (fast-prime? n (- times 1)))
            (else #f)))
   (define (fermat-test n)
      (try-it (+ 1 (random (- n 1)))))
   (define (try-it a)
      (= (expmod a n n) a))
   (define (expmod base exp_ m)
      (cond ((= exp_ 0) 1)
            ((even? exp_) (remainder (square (expmod base (/ exp_ 2) m)) m))
            (else (remainder (* base (expmod base (- exp_ 1) m)) m))))
   (define (next n)
      (if (even? n)
          (+ n 1)
          (+ n 2))) 
   (fast-prime? n 10))
