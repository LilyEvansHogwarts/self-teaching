(load "2.78-put-and-get.scm")
(load "2.78-tag.scm")

(define (apply-generic op . args)
  (define (coerce-list-to-type lst type)
    (if (null? lst)
      ()
      (let ((t1->t2 (get-coersion (type-tag (car lst)) type)))
	(if t1->t2
	  (cons (t1->t2 (car lst)) (coerce-list-to-type (cdr lst) type))
	  (cons (car lst) (coerce-list-to-type (cdr lst) type))))))
  (define (apply-coerced lst)
    (if (null? lst)
      (error "No method for given arguments")
      (let ((coerced-list (coerce-list-to-type args (type-tag (car lst)))))
	(let ((proc (get op (map type-tag coerced-list))))
	  (if proc
	    (apply proc (map contents coerced-list))
	    (apply-coerced (cdr lst)))))))
  (let ((type-tags (map type-tags args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(apply-coerced args)))))

(define (real-part_ z) (apply-generic 'real-part_ z))

(define (imag-part_ z) (apply-generic 'imag-part_ z))

(define (magnitude_ z) (apply-generic 'magnitude_ z))

(define (angle_ z) (apply-generic 'angle_ z))

(define (add x y) (apply-generic 'add x y))

(define (sub x y) (apply-generic 'sub x y))

(define (mul x y) (apply-generic 'mul x y))

(define (div x y) (apply-generic 'div x y))

(define (equ? x y) (apply-generic 'equ? x y))

(define (=zero? x) (apply-generic '=zero? x))
