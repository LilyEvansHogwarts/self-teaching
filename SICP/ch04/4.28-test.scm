(load "p279-eval.scm")

(define a '(begin (define (square x) (* x x))
				  (define (halve x) (/ x 2))
				  (define (combine f g)
				   (lambda (n)
					(f (g n))))
				  ((combine square halve) 10)))

(interpret a)
