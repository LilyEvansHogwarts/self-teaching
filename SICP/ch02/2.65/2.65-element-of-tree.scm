(load "2.65-entry.scm")
(load "2.65-left-branch.scm")
(load "2.65-right-branch.scm")
(define (element-of-tree? x set)
  (cond ((null? set) #f)
	((= (entry set) x) #t)
	((< x (entry set)) (element-of-tree? x (left-branch set)))
	((> x (entry set)) (element-of-tree? x (right-branch set)))))
