(define (make-table)
  (list '*table*))

(define (lookup key1 key2 table)
  (let ((subtable (assoc key1 (cdr table))))
    (if subtable
      (let ((record (assoc key2 (cdr subtable))))
	(if record
	  (cdr record)
	  false))
      false)))

(define (assoc key table)
  (cond ((null? table) false)
	((eq? key (caar table)) (car table))
	(else (assoc key (cdr table)))))

(define (insert! key1 key2 value table)
  (let ((subtable (assoc key1 (cdr table))))
    (if subtable
      (let ((record (assoc key2 (cdr subtable))))
	(if record
	  (set-cdr! record value)
	  (set-cdr! subtable (cons (cons key2 value) (cdr subtable)))))
      (set-cdr! table (cons (list key1 (cons key2 value)) (cdr table))))))

(define (print-table table)
  (display table)
  (newline))
