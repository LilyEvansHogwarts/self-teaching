;;;**************************************
;;;               构造函数
;;;**************************************

(define (make-tree key value left-branch right-branch)
  (list key value left-branch right-branch))

;;;**************************************
;;;               选择函数
;;;**************************************

(define (tree-key tree)
  (car tree))

(define (tree-value tree)
  (cadr tree))

(define (tree-left-branch tree)
  (caddr tree))

(define (tree-right-branch tree)
  (cadddr tree))

;;;**************************************
;;;               改变函数
;;;**************************************

(define (set-key! tree key)
  (set-car! tree key))

(define (set-value! tree value)
  (set-car! (cdr tree) value))

(define (set-left-branch! tree branch)
  (set-car! (cddr tree) branch))

(define (set-right-branch! tree branch)
  (set-car! (cdddr tree) branch))

;;;*************************************
;;;              lookup
;;;*************************************

(define (lookup tree given-key compare)
  (if (tree-empty? tree)
    '()
    (let ((compare-result (compare given-key (tree-key tree))))
      (cond ((= compare-result 0)
	     (tree-value tree))
	    ((= compare-result 1)
	     (lookup (tree-right-branch tree) given-key compare))
	    ((= comapre-result -1)
	     (lookup (tree-left-branch tree) given-key compare))))))

;;;*************************************
;;;              insert!
;;;*************************************

(define (insert! tree given-key value compare)
  (if (tree-empty? tree)
    (make-tree given-key value '() '())
    (let ((compare-result (compare given-key (tree-key tree))))
      (cond ((= compare-result 0)
	     (set-value! tree value))
	    ((= compare-result 1)
	     (set-right-branch! tree (insert! (tree-right-branch tree) given-key value compare)))
	    ((= compare-result -1)
	     (set-left-branch! tree (insert! (tree-left-branch tree) given-key value compare))))
      tree)))

;;;*************************************
;;;            tree-empty?
;;;*************************************

(define (tree-empty? tree)
  (null? tree))

;;;*************************************
;;;             compare
;;;*************************************

(define (compare-number a b)
  (cond ((= a b) 0)
	((> a b) 1)
	((< a b) -1)))

(define (compare-string a b)
  (cons ((string=? a b) 0)
	((string>? a b) 1)
	((string<? a b) -1)))

(define (compare-symbol a b)
  (compare-string (symbol->string a)
		  (symbol->string b)))
