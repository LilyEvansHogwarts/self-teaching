(define (fib n)
   (define (fib-iter a b n)
      (if (= n 0)
          a
          (fib-iter b (+ a b) (- n 1))))
   (fib-iter 0 1 n))

