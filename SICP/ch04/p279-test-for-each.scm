(load "p279-eval.scm")

(define a '(begin (define (for-each proc items)
				   (if (null? items)
					'done
					(begin (proc (car items))
						   (for-each proc (cdr items)))))
				  (for-each (lambda (x) (newline) (display x))
							(list 57 321 88))))

(interpret a)
