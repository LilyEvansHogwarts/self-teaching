(define random-init 100086)

(define (rand s)
  (let ((state random-init))
    (cond ((eq? s 'generate) (random random-init))
	  ((eq? s 'reset) (lambda (x) (begin (set! state x)
					     x)))
	  (else (error "Unknow mode -- RAND" s)))))
