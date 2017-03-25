(define (expr b n)
   (define (expr-iter b n product)
      (if (= n 0)
          product
          (expr-iter b (- n 1) (* b product))))
   (expr-iter b n 1))
