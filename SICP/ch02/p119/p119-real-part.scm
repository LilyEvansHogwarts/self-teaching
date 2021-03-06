(load "p119-rectangular.scm")
(load "p119-polar.scm")
(load "p119-real-part-rectangular.scm")
(load "p119-real-part-polar.scm")
(define (real-part_ z)
  (cond ((rectangular? z) (real-part-rectangular z))
	((polar? z) (real-part-polar z))
	(else (error "Unknown type -- REAL-PART" z))))
