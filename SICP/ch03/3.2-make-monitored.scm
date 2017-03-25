(define counter 0)

(define (make-monitored f)
  (lambda (x) 
    (cond ((eq? x 'how-many-calls?) counter)
	  ((eq? x 'reset-count) (begin (set! counter 0)
				       counter))
	  (else (begin (set! counter (+ counter 1))
		       (f x))))))
