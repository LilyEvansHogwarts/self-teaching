(define (lookup key-list table)
  (if (list? key-list)
    (let ((current-key (car key-list))
	  (remain-key (cdr key-list)))
      (let ((subtable (assoc current-key (cdr table))))
	(if subtable
	  (if (null? remain-key)
	    (cdr table)
	    (lookup remain-key subtable))
	  false)))
    (lookup (list key-list) table)))

(define (assoc key table)
  (cond ((null? table) false)
	((equal? key (caar table)) (car table))
	(else (assoc key (cdr table)))))

(define (insert! key-list value table) ;;;由于需要递归的创建，即insert!函数中存在着进一步调用insert!的问题，需要一个返回值table，因而此处的table，不能省
  (if (list? key-list)
    (let ((current-key (car key-list))
	  (remain-key (cdr key-list)))
      (let ((subtable (assoc current-key (cdr table))))
	(cond ((and subtable (null? remain-key))
	       (set-cdr! subtable value)
	       table)
	      ((and subtable (not (null? remain-key)))
	       (insert! remain-key value subtable)
	       table)
	      ((and (not subtable) (null? remain-key))
	       (let ((new-record (cons current-key value)))
		 (join-in-table new-record table)
		 table))
	      ((and (not subtable) (not (null? remain-key)))
	       (join-in-table (insert! remain-key value (list current-key)) table)
	       table))))
    (insert! (list key-list) value table)))

(define (join-in-table new-table table)
  (set-cdr! table (cons new-table (cdr table))))

(define (make-table)
  (list '*table*))


