(load "lazy-memo-eval.scm")

(define a '(begin (define (append (a lazy) (b lazy-memo))
				   (if (null? a)
					b
					(cons (car a) (append (cdr a) b))))
				  (append '(a b c) '(e f g))))

(interpret a)
