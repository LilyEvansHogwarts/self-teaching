(define (assoc key records)
  (cond ((null? records) false)
	((equal? key (caar records)) (car records))
	(else (assoc key (cdr records)))))

(define (lookup key-list table)
  (if (list? key-list)
    (let ((current-key (car key-list))
	  (remain-key (cdr key-list)))
      (let ((records (assoc current-key (cdr table))))
	(if records
	  (if (null? remain-key)
	    (cdr records)
	    (lookup remain-key records))
	  false)))
    (lookup (list key-list) table)))

(define (insert! key-list value table)
  (if (list? key-list)
    (let ((current-key (car key-list))
	  (remain-key (cdr key-list)))
      (let ((records (assoc current-key (cdr table))))
	(if records
	  (if (null? remain-key)
	    (set-cdr! records value)
	    (insert! remain-list value records))
	  (if (null? remain-key)
	    (let ((new-pair (cons current-key value)))
	      (join-in new-pair table))
	      (join-in (insert! remain-key value (list current-key)) table)))
	table))
    (insert! (list key-list) value table)))

(define (join-in new-table table)
  (set-cdr! table (cons new-table (cdr table))))

(define (make-table)
  (list '*table*))

