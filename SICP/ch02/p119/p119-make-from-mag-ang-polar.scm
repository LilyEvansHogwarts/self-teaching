(load "p119-attach-tag.scm")
(define (make-from-magnitude-angle-polar x y)
  (attach-tag 'polar (cons x y)))
