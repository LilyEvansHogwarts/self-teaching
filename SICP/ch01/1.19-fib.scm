(define (fib n)
   (define (fib-iter a b p q count)
      (cond ((= count 0) b)
            ((even? count) (fib-iter a b (+ (square p) (square q)) (+ (* 2 p q) (square q)) (/ count 2)))
            (else (fib-iter (+ (* b q) (* a p) (* a q))
                             (+ (* b p) (* a q))
                             p 
                             q
                             (- count 1)))))
   (fib-iter 1 0 0 1 n))
