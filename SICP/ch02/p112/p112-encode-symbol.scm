(load "p112-element-of-set.scm")
(load "p112-symbols.scm")
(load "p112-left-branch.scm")
(load "p112-right-branch.scm")
(load "p112-leaf.scm")
(define (encode-symbol x tree)
  (cond ((leaf? tree) ()) 
	((and (not (leaf? tree)) (element-of-set? x (symbols (left-branch tree)))) (cons '0 (encode-symbol x (left-branch tree))))
	((and (not (leaf? tree)) (element-of-set? x (symbols (right-branch tree)))) (cons '1 (encode-symbol x (right-branch tree))))
	(else (error "bad symbol -- ENCODE SYMBOL" x))))
