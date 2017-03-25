(load "2.65-partial-tree.scm")
(define (list->tree elements)
  (car (partial-tree elements (length elements))))
