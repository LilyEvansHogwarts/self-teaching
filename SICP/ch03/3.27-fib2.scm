(define (make-table)
  (list '*table*))

(define (empty-table? table)
  (null? (cdr table)))

(define (assoc key records)
  (cond ((null? records) false)
	((eq? key (caar records)) (car records))
	(else (assoc key (cdr records)))))

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

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x) 
      (let ((previously-computed-result (lookup x table)))
	(or previously-computed-result
	    (let ((result (f x)))
	      (insert! x result table)
	      result))))))

(define (fib n)
  (cond ((= n 0) 0)
	((= n 1) 1)
	(else (+ (fib (- n 1))
		 (fib (- n 2))))))

(define memo-fib
  (memoize fib))

