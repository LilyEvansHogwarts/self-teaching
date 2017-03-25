(load "p119-type-tag.scm")
(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))
