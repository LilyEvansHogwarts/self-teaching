(define (same-parity first . rest)
   (define (same-parity-iter source dist remainder-val)
      (if (null? source)
          dist
          (if (= (remainder (car source) 2) remainder-val)
              (same-parity-iter (cdr source) (append dist (list (car source))) remainder-val)
              (same-parity-iter (cdr source) dist remainder-val))))
   (same-parity-iter rest (list first) (remainder first 2)))
         
