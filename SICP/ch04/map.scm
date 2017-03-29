(define (map action a b)
 (cond ((null? a) '())
	   ((null? b) '())
	   (else (cons (action (car a) (car b)) (map action (cdr a) (cdr b))))))
