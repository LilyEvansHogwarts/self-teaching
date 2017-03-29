(load "p129-complex.scm")
(load "p124-rectangular.scm")
(load "p124-polar.scm")
(load "p124-apply-generic.scm")
(load "p129-scheme-number.scm")
(load "p129-rational.scm")

(define (test)
  (display "well prepared.")
  (newline)
  (install-rectangular-package)
  (display "well prepared.")
  (newline)
  (install-polar-package)
  (display "well prepared.")
  (newline)
  (install-complex-package)
  (display "well prepared.")
  (newline)
  (define a (make-complex-from-real-imag 3 4))
  (display a)
  (newline)
  (display (magnitude_ a))
  (newline)
  (install-scheme-number-package)
  (display "Well prepared.")
  (newline)
  (define b (make-scheme-number 3))
  (display b)
  (newline)
  (define c (make-scheme-number 4))
  (display c)
  (newline)
  (display (add b c))
  (newline))