(load "2.64-partial-tree.scm")
(define (list->tree elements)
  (car (partial-tree elements (length elements))))
