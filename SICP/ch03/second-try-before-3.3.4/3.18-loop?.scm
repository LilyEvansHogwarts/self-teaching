(define (loop? x)
  (let ((identity (cons '() '())))
    (define (iter lst)
      (cond ((null? lst) false)
	    ((eq? identity (car lst)) true)
	    (else (set-car! lst identity)
		  (iter (cdr lst)))))
    (iter x)))

