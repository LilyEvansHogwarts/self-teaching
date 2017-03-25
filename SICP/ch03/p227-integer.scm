(load "p222-stream.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))

(define no-sevens
  (stream-filter (lambda (x) (not (divisible? x 7))) integers))

(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))

(define fibs (fibgen 0 1))

(define (sieve stream)
  (cons-stream
    (stream-car stream)
    (sieve (stream-filter (lambda (x) (not (divisible? x (stream-car stream))))
			  (stream-cdr stream)))))

(define prime (sieve (integers-starting-from 2)))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define one (cons-stream 1 one))

(define integers (cons-stream 1 (add-streams one integers)))

(define fibs
  (cons-stream 0 
	       (cons-stream 1 
			    (add-streams (stream-cdr fibs)
					 fibs))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define double (cons-stream 1 (scale-stream double 2)))

(define (prime? x)
  (define (iter n)
    (cond ((> (square n) x) true)
	  ((= (remainder x n) 0) false)
	  (else (iter (+ n 1)))))
  (iter 2))

(define primes (cons-stream 2 (stream-filter prime? (integers-starting-from 3))))
