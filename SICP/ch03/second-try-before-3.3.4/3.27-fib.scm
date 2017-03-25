;;;******************************
;;;           make-table
;;;******************************

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

;;;********************************
;;;           fib
;;;********************************

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((result (lookup x table)))
	(or result
	    (let ((r (f x)))
	      (insert! x r table)
	      r))))))

(define memo-fib
  (memoize (lambda (n)
	     (cond ((= n 0) 0)
		   ((= n 1) 1)
		   (else (+ (memo-fib (- n 2))
			    (memo-fib (- n 1))))))))

(define (fib n)
  (cond ((= n 0) 0)
	((= n 1) 1)
	(else (+ (fib (- n 2))
		 (fib (- n 1))))))
