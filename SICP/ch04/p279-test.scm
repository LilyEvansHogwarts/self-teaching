(load "p279-test.scm")

(define a '(begin (define (try a b)
				   (if (= b 0)
					a
					(/ a b)))
				  (try 1 0)))
(define b '(begin (define (append a b)
				   (if (null? a)
					b
					(cons (car a) (append (cdr a) b))))
			(append '(a b c) '(e f g))))
(interpret a)
