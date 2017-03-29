(load "p112-make-leaf-set.scm")
(load "p112-make-leaf.scm")
(load "p112-make-code-tree.scm")
(load "2.69-generate-huffman-tree.scm")
(define (test)
  (define a (list 'A 4))
  (define b (list 'B 2))
  (define c (list 'C 1))
  (define d (list 'D 1))
  (define x (list a b c d))
  (define sample-tree
    (make-code-tree (make-leaf 'A 4)
		    (make-code-tree (make-leaf 'B 2)
				    (make-code-tree (make-leaf 'D 1)
						    (make-leaf 'C 1)))))
  (display (generate-huffman-tree x))
  (newline)
  (display sample-tree))