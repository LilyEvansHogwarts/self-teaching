(define (pairs s t)
  (cons-stream (list (stream-car s) (stream-car t))
	       (interleave (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
			      (pairs (stream-cdr s) (stream-cdr t)))))

(define (stream-append s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
		 (stream-append (stream-cdr s1) s2))))

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
		 (interleave s2 (stream-cdr s1)))))

(define (stream-filter proc stream)
  (if (stream-null? stream)
    'done
    (if (proc (stream-car stream))
      (cons-stream (stream-car stream) (stream-filter proc (stream-cdr stream)))
      (stream-filter proc (stream-cdr stream)))))

(define (prime? x)
  (define (iter n)
    (cond ((= x 2) true)
          ((> (square n) x) true)
	  ((= (remainder x n) 0) false)
	  (else (iter (+ n 1)))))
  (iter 2))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define q (pairs integers integers))

(define p (stream-filter (lambda (s) (prime? (+ (car s) (cadr s)))) q))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show p) n))

