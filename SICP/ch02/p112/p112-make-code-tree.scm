(load "p112-symbols.scm")
(load "p112-weight.scm")
(define (make-code-tree left right)
  (list left right (append (symbols left) (symbols right)) (+ (weight left) (weight right))))
