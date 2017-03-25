(load "p112-choose-branch.scm")
(load "p112-symbol-leaf.scm")
(load "p112-leaf.scm")
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      ()
      (let ((next-branch (choose-branch (car bits) current-branch)))
	(if (leaf? next-branch)
	  (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
	  (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
