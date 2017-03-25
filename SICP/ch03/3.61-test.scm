(load "3.61-reciprocal.scm")

(define exp-series (cons-stream 1 (integrate-series exp-series)))

(define (integrate-series stream)
  (stream-map / stream integers))

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define cosine-series (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define (scale-stream stream factor)
  (stream-map (lambda (s) (* s factor)) stream))

(define result (reciprocal exp-series))
