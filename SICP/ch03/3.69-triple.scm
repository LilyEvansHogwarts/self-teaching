(define (num)
  (define numbers (triple integers integers integers))
  (stream-filter (lambda (x)
		   (= (square (caddr x)) 
		      (+ (square (car x)) (square (cadr x)))))
		 numbers))

(define (triple s t u)
  (cons-stream (list (stream-car s) (stream-car t) (stream-car u))
	       (interleave (stream-map (lambda (x) (cons (stream-car s) x))
							 (stream-cdr (pairs t u)))
			   (triple (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (pairs t u)
  (cons-stream (list (stream-car t) (stream-car u))
	       (interleave (stream-map (lambda (x) (list (stream-car t) x)) (stream-cdr u))
			   (pairs (stream-cdr t) (stream-cdr u)))))

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
		 (interleave s2 (stream-cdr s1)))))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show (num)) n))
