(define (stream-ref s n)
 (if (= n 0)
  (stream-car s)
  (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
 (if (stream-null? s)
  the-empty-stream
  (cons-stream (proc (stream-car s))
   (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
 (if (stream-null? s)
  'done
  (begin (proc (stream-car s))
   (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
 (stream-for-each display-line s))

(define (display-line x)
 (newline)
 (display x))

(define (stream-enumerate-interval low high)
 (if (> low high)
  the-empty-stream
  (cons-stream low 
   (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter proc s)
 (if (stream-null? s)
  the-empty-stream
  (if (proc (stream-car s))
   (cons-stream (stream-car s) (stream-filter proc (stream-cdr s)))
   (stream-filter proc (stream-cdr s)))))

(define (prime? x)
 (define (iter n)
  (cond ((or (= x 1) (= x 0)) false)
        ((> (square n) x) true)
		((= 0 (remainder x n)) false)
		(else (iter (+ n 1)))))
 (iter 2))

(define ans (stream-car (stream-cdr (stream-filter prime? (stream-enumerate-interval 10000 1000000)))))

(define (enumerate-interval low high)
 (if (> low high)
  '()
  (cons low (enumerate-interval (+ low 1) high))))

(define haha (filter prime? (enumerate-interval 1 100)))

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2)
 (cond ((stream-null? s1) s2)
	   ((stream-null? s2) s1)
	   (else (cons-stream (+ (stream-car s1) (stream-car s2))
			  (add-streams (stream-cdr s1) (stream-cdr s2))))))

(define integers (cons-stream 1 (add-streams ones integers)))

(define fibs (cons-stream 0 (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

(define (scale-stream stream factor)
 (stream-map (lambda (x) (* x factor)) stream))

(define (integers-starting-from n)
 (cons-stream n (integers-starting-from (+ n 1))))

(define primes (stream-map prime? (integers-starting-from 1)))

(define double (cons-stream 1 (scale-stream double 2)))

(define zeros (cons-stream 0 zeros))

(define (mul-streams s1 s2)
 (cond ((stream-null? s1) zeros)
	   ((stream-null? s2) zeros)
	   (else (cons-stream (* (stream-car s1) (stream-car s2)) 
			  (mul-streams (stream-cdr s1) (stream-cdr s2))))))

(define inverse-integers (stream-map (lambda (x) (/ 1 x)) integers))

(define ex (cons-stream 1 (mul-streams ex inverse-integers)))

(define (queue x)
 (define q1 (cons-stream x q1))
 (define q2 (cons-stream 1 (mul-streams q2 q1)))
 q2)

(define cosine (cons-stream 1 (mul-streams sine (stream-map (lambda (x) (- x)) inverse-integers))))
(define sine (cons-stream 0 (mul-streams cosine inverse-integers)))

(define (display-stream items n)
 (cond ((= n 0) (newline))
	   (else (display (stream-car items))
		(display "    ")
		(display-stream (stream-cdr items) (- n 1)))))
