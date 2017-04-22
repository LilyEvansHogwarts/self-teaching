(load "lazy2-eval.scm")

(define a '(begin (define (append a b)
				   (if (null? a)
					b
					(cons (car a) (append (cdr a) b))))
				  (append '(a b c) '(e f g))))

(interpret a)
