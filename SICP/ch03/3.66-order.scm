(load "p236-pairs1.scm")

(define (order stream pair)
  (define (iter stream pair n)
    (let ((head (stream-car stream)))
      (if (and (= (car pair) (car head)) (= (cadr pair) (cadr head)))
	n
	(iter (stream-cdr stream) pair (+ n 1)))))
  (iter stream pair 0))

(define (test pair)
  (order q pair))
