(load "p112-make-code-tree.scm")
(load "p112-adjoin-set.scm")
(load "p112-make-leaf-set.scm")
(define (generate-huffman-tree pairs)
  (define (successive-merge pairs)
    (if (= 1 (length pairs))
      pairs
      (let ((tree (make-code-tree (car pairs) (cadr pairs))))
	(if (null? (cddr pairs))
	  tree
	  (successive-merge (adjoin-set tree (cddr pairs)))))))
  (successive-merge (make-leaf-set pairs)))
