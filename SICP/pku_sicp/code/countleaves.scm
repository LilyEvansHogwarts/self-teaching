(define (countleaves tree)
 (cond ((null? tree) 0)
	   ((leaf? tree) 1)
	   (else (+ (countleaves (car tree)) (countleaves (cdr tree))))))

(define (tree-map proc tree)
 (cond ((null? tree) tree)
	   ((leaf? tree) (proc tree))
	   (else (cons (tree-map proc (car tree)) (tree-map proc (cdr tree))))))

(define (leaf? x) (not (pair? x)))

(define haha (list 2 (list 2 3) (list 4 5 6 7)))

(define (tree-manip leaf-op init merge tree)
 (cond ((null? tree) init)
	   ((leaf? tree) (leaf-op tree))
	   (else (merge (tree-manip leaf-op init merge (car tree))
				    (tree-manip leaf-op init merge (cdr tree))))))

(define (tree-map2 proc tree)
 (tree-manip proc '() cons tree))

(define (left-branch tree) (car tree))

(define (entry tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree left-branch entry right-branch)
 (list left-branch entry right-branch))

