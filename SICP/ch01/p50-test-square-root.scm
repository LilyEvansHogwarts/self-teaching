(load "p50-fixed-point-of-transform.scm")
 
(define (square-root n)
   (define (root y) (- (square y) n))
   (fixed-point-of-transform root n))
