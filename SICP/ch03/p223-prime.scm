(define (prime? x)
  (define (iter n)
    (cond ((> (square n) x) true)
	  ((not (= (remainder x n) 0)) (iter (+ n 1)))
	  (else false)))
  (iter 2))

(define (stream-filter proc s)
  (if (stream-null? s)
    the-empty-stream
    (let ((head (stream-car s)))
      (if (proc head)
	(cons-stream head (stream-filter proc (stream-cdr s)))
	(stream-filter proc (stream-cdr s))))))

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream low (stream-enumerate-interval (+ low 1) high))))

(stream-car (stream-cdr (stream-filter prime? (stream-enumerate-interval 10000 1000000))))

