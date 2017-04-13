(load "4.31-lazy-memo.scm")

(define a '(begin (define (p2 x)
				   (define (p e)
					e
					x)
				   (p (set! x (cons x '(2)))))
				  (p2 1)))
(display a)
(newline)
(display (interpret a))
(newline)

(define b '(begin (define (p2 x)
				   (define (p (e lazy))
					e
					x)
				   (p (set! x (cons x '(2)))))
				  (p2 1)))
(display b)
(newline)
(display (interpret b))
(newline)
