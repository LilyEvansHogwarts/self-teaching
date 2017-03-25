(load "p123-put-and-get.scm")
(load "p119-tag.scm")

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(error "No method for these types -- APPLY-GENERIC" (list op type-tags))))))

(define (real-part_ z) (apply-generic 'real-part_ z))

(define (imag-part_ z) (apply-generic 'imag-part_ z))

(define (magnitude_ z) (apply-generic 'magnitude_ z))

(define (angle_ z) (apply-generic 'angle_ z))

(define (add x y) (apply-generic 'add x y))

(define (sub x y) (apply-generic 'sub x y))

(define (mul x y) (apply-generic 'mul x y))

(define (div x y) (apply-generic 'div x y))
