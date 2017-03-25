(define (average-damp f)
   (lambda (x) (/ (+ x (f x)) 2)))
