(define (prime? x)
  (define (iter n)
    (cond ((< x 2) false)
          ((> (square n) x) true)
	  ((= (remainder x n) 0) false)
	  (else (iter (+ n 1)))))
  (iter 2))

(define (stream-filter proc stream)
  (if (stream-null? stream)
    'done
    (if (proc (stream-car stream))
      (cons-stream (stream-car stream) (stream-filter proc (stream-cdr stream)))
      (stream-filter proc (stream-cdr stream)))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define prime-num (stream-filter prime? integers))

(define (pairs stream n)
  (if (stream-null? stream)
    'done
    (let ((head (stream-car stream))
	  (tail (stream-cdr stream)))
      (cond ((or (= head (* 2 n)) (= head (+ 1 (* 2 n)))) (cons-stream (list n (- head n)) (pairs tail 1)))
	    (else (cons-stream (list n (- head n)) (pairs stream (+ n 1))))))))

(define (show x)
  (newline)
  (display x)
  x)

(define (stream-map proc . args)
  (if (stream-null? args)
    the-empty-stream
    (cons-stream (apply proc (map stream-car args))
		 (apply stream-map (cons proc (map stream-cdr args))))))

(define (s n)
  (stream-ref (stream-map show (pairs prime-num 1)) n))


