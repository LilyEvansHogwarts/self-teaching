(define (make-table)
  (list '*table*))

(define (assoc key records)
  (cond ((null? records) false)
	((eq? key (caar records)) (car records))
	(else 
	  (assoc key (cdr records)))))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
      (cdr record)
      false)))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
      (set-cdr! record value)
      (set-cdr! table (cons (cons key value) (cdr table))))))
