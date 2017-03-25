(define (rand-generator commands)
  (define (rand-helper init remaining-commands)
    (let ((next-command (stream-car remaining-commands)))
      (cond ((eq? next-command 'generate)
	     (cons-stream init (rand-helper (rand-update init)
					    (stream-cdr remaining-commands))))
	    ((pair? next-command)
	     (if (eq? (car next-command) 'reset)
	       (cons-stream (cdr next-command)
			    (rand-helper (rand-update (cdr next-command))
					 (stream-cdr remaining-commands)))
	       (error "no such operation -- RAND-GENERATOR" next-command)))
	    (else
	      (error "no such operation -- RAND-GENERATOR" next-command)))))
  (rand-helper 12 commands))

(define gen 
  (cons-stream (cons 'reset 100)
	       (cons-stream 'generate
			    (cons-stream 'generate 
					 (cons-stream (cons 'reset 12)
						      (cons-stream 'generate
								   (cons-stream 'generate
										gen)))))))

(define (rand-update x)
  (remainder (+ (* 13 x) 5) 24))

(define q (rand-generator gen))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show q) n))
