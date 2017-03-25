(define (cont-frac n d k)
   (define (try i)
      (if (= i k)
          (/ (n i) (d i))
          (/ (n i) (+ (d i) (try (+ 1 i))))))  
   (try 1))
      
