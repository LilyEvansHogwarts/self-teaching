(load "2.58b-deriv.scm")
(load "2.58b-change-style.scm")
(define (change-style-deriv expression var)
  (change-style (deriv expression var)))
