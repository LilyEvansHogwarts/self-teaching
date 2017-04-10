(define (report start-time)
 (display "Runtime: ")
 (display (- (runtime) start-time))
 (newline))

(define a
 '(begin (define (factorial n)
			(if (< n 2)
			 1
			 (* n (factorial (- n 1)))))
		 (define (fib n)
			(cond ((= n 0) 0)
				  ((= n 1) 1)
				  (else (+ (fib (- n 1)) (fib (- n 2))))))
		 (factorial 50)
		 (fib 20)))

(define (runtime-interpret exp)
 (let ((start-time (runtime)))
  (display "Result: ")
  (display (interpret exp))
  (newline)
  (report start-time)))

(load "no-analyze.scm")
(newline)
(display "without analyze")
(newline)
(runtime-interpret a)
(runtime-interpret a)
(runtime-interpret a)

(load "with-analyze.scm")
(newline)
(display "with analyze")
(newline)
(runtime-interpret a)
(runtime-interpret a)
(runtime-interpret a)
