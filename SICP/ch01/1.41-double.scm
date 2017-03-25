(define (test x)
   (define (double g)
      (lambda (x) (g (g x))))
   ((double (double (double (lambda (x) (+ x 1))))) x))
