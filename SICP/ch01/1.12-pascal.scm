(define (pascal row column)
   (define (factorial a n)
      (if (= n 1)
          a
          (factorial (* a n) (- n 1))))
   (define (fac n)
      (factorial 1 n))
   (/ (fac row) (* (fac column) (fac (- row column)))))
