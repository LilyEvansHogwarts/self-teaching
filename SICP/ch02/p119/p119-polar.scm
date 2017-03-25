(load "p119-type-tag.scm")
(define (polar? z)
  (eq? (type-tag z) 'polar))
