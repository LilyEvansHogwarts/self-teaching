(load "p119-magnitude-polar.scm")
(load "p119-angle-polar.scm")
(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))
