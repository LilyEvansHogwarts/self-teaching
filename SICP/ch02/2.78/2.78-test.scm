(load "2.78-scheme-number.scm")
(load "2.78-apply-generic.scm")
(load "2.78-put-and-get.scm")

(define (test)
  (display "well prepared.")
  (newline)
  (install-scheme-number-package)
  (display "well prepared.")
  (newline)
  (define a (make-scheme-number 3))
  (display a)
  (newline)
  (define b (make-scheme-number 4))
  (display b)
  (newline)
  (display ((get 'add '(scheme-number scheme-number)) a b)))
