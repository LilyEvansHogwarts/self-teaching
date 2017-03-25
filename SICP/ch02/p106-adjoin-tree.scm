(load "p106-entry.scm")
(load "p106-make-tree.scm")
(load "p106-right-branch.scm")
(load "p106-left-branch.scm")
(define (adjoin-tree x set)
  (cond ((null? set) (list x () ()))
	((= x (entry set)) set)
	((< x (entry set)) (make-tree (entry set) (adjoin-tree x (left-branch set)) (right-branch set)))
	((> x (entry set)) (make-tree (entry set) (left-branch set) (adjoin-tree x (right-branch set))))))
