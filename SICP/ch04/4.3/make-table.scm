(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key)
      (let ((record (assoc key (cdr local-table))))
	(if record
	  (cdr record)
	  false)))
    (define (assoc key records)
      (cond ((null? records) false)
	    ((eq? key (caar records)) (car records))
	    (else (assoc key (cdr records)))))
    (define (insert! key value)
      (let ((record (assoc key (cdr local-table))))
	(if record
	  (set-cdr! record value)
	  (set-cdr! local-table (cons (cons key value) (cdr local-table))))))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
	    ((eq? m 'insert-proc!) insert!)
	  ;;;  (else (error "Unknown operation -- TABLE" m))))
	    (else false)))
    dispatch))

(define operation-table (make-table))

(define get (operation-table 'lookup-proc))

(define put (operation-table 'insert-proc!))
