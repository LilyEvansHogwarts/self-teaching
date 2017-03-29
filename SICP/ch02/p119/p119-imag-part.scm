(load "p119-rectangular.scm")
(load "p119-polar.scm")
(load "p119-imag-part-rectangular.scm")
(load "p119-imag-part-polar.scm")
(define (image-part_ z)
  (cond ((rectangular? z) (imag-part-rectangular z))
	((polar? z) (image-part-polar z))
	(else (error "Unknown type -- IMAGE-PART" z))))