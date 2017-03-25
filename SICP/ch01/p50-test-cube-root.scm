(load "p50-fixed-point-of-transform.scm")

(define (cube-root n)
   (define (root y) (- (* y y y) n))
   (fixed-point-of-transform root n))
