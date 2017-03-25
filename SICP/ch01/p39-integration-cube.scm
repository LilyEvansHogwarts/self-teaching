(load "p39-integration.scm")

(define (integration-cube a b dx)
   (define (cube x) (* x x x))
   (integration cube a b dx))
