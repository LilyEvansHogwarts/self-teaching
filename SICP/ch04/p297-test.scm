(load "p297-analyze.scm")

(define a '(begin (define (append x y)
				   (if (null? x)
					y
					(cons (car x) (append (cdr x) y))))
				  (append '(a b c) '(e f g))))

(interpret a)
