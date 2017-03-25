(load "p119-magnitude-polar.scm")
(load "p119-angle-polar.scm")
(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
