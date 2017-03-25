(load "p46-fixed-point2.scm")

(define (log_ n)
   (fixed-point (lambda (x) (/ (log 1000) (log x))) n))
