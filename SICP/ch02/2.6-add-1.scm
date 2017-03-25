(define (add-1 n)
   (lambda (f) (lambda (x) (f ((n f) x)))))
