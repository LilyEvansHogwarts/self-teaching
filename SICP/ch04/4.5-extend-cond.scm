(define (extended-cond-syntax? clause) (eq? (cadr clause) '=>))
(define (extended-cond-test clause) (car clause))
(define (extended-cond-recipient clause) (caddr clause))
(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
	  (rest (cdr clauses)))
      (if (cond-else-clauses? first)
	(if (null? rest)
	  (sequence->exp (cond-actions first))
	  (error "ELSE clause isn't last -- COND->if" clauses))
	(if (extended-cond-syntax? first)
	  (make-if (extended-cond-test first)
		   (apply (extended-cond-recipient first) (extended-cond-test first))
		   (expand-clauses rest))
	  (make-if (cond-predicate first)
		   (sequence->exp (cond-actions first))
		   (expand-clauses rest)))))))
