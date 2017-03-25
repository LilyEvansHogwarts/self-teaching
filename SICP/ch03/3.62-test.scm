(load "3.62-div-series.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (integrate-series stream)
  (stream-map / stream integers))

(define (stream-map proc . args)
  (if (null? (car args))
    the-empty-stream
    (cons-stream (apply proc (map (lambda (s) (stream-car s)) args))
		 (apply stream-map (cons proc (map (lambda (s) (stream-cdr s)) args))))))

(define cosine-series (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define tan-series (div-series sine-series cosine-series))

