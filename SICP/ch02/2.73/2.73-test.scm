(load "2.73-install-sum-package.scm")
(load "2.73-install-product-package.scm")
(load "2.73-install-exponentiation-package.scm")
(load "2.73-deriv.scm")

(define (test expression var)
  (install-sum-package)
  (install-product-package)
  (install-exponentiation-package)
  (deriv expression var))
