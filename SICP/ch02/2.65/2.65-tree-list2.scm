(load "2.65-entry.scm")
(load "2.65-left-branch.scm")
(load "2.65-right-branch.scm")
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
      result-list
      (copy-to-list (left-branch tree) (cons (entry tree) (copy-to-list (right-branch tree) result-list)))))
  (copy-to-list tree ()))
