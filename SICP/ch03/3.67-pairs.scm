(define (pairs s1 s2)
  (cons-stream (list (stream-car s1) (stream-car s2))
	       (interleave (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2))
			   (stream-map (lambda (x) (list x (stream-car s2))) (stream-cdr s1))
			   (pairs (stream-cdr s1) (stream-cdr s2)))))

(define (interleave a1 a2 a3)
  (cons-stream (stream-car a1) 
	       (cons-stream (stream-car a2)
			    (cons-stream (stream-car a3)
					 (interleave (stream-cdr a1)
						     (stream-cdr a2)
						     (stream-cdr a3))))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define q (pairs integers integers))

(define (show x)
  (newline)
  (display x)
  x)

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map stream-car args))
		 (apply stream-map (cons proc (map stream-cdr args))))))

(define (s n)
  (stream-ref (stream-map show q) n))
