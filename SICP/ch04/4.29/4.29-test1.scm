(load "4.29-without-evaluated-thunk.scm")

(define a '(begin (define (fib n)
				   (cond ((= n 0) 0)
						 ((= n 1) 1)
						 (else (+ (fib (- n 1)) (fib (- n 2))))))
				  (define (test x)
				   (define (iter t)
					(if (= t 0)
					 0
					 (+ x (iter (- t 1)))))
				   (iter 10))
				  (test (fib 10))))

(define (runtime-interpret exp)
 (let ((start-time (runtime)))
  (display "Result: ")
  (display (interpret a))
  (display "  Running time: ")
  (display (- (runtime) start-time))
  (newline)))

(runtime-interpret a)



(load "4.29-with-evaluated-thunk.scm")
(runtime-interpret a)
