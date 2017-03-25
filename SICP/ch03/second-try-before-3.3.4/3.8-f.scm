(define count 0)

(define (f1 n)
  (set! count (+ count 1))
  (if (odd? count)
    n
    0))

(define f2
  (lambda (first-args)
    (set! f2 (lambda (second-args) 0))
    first-args))

(define (test)
  (let ((first (+ (f1 0)
		  (f1 1)))
	(second (+ (f2 0)
		   (f2 1))))
    (display first)
    (newline)
    (display second)))
