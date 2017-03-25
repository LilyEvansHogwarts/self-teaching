(load "3.50-stream-map.scm")

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (stream-map1 proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s)) (stream-map1 proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
	   (stream-for-each proc (stream-cdr s)))))

(define a1 (cons-stream 4 the-empty-stream))
(define a2 (cons-stream 3 a1))
(define a3 (cons-stream 2 a2))
(define a4 (cons-stream 1 a3))

(define (add-one x)
  (+ x 1))

(define a a4)
(define b (stream-map1 add-one a))
(define c (stream-map1 add-one b))
(define d (stream-map1 add-one c))

;;;(define E (cons-stream d the-empty-stream))
;;;(define F (cons-stream c E))
;;;(define G (cons-stream b F))
;;;(define H (cons-stream a G))

;;;(define K (stream-map (lambda (s) (stream-car s)) H))

(define (sum a b c d) (+ a b c d))

(define Q (stream-map sum a b c d))

(display-stream Q)
