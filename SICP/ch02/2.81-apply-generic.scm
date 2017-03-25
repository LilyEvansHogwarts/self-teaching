(load "2.78-put-and-get.scm")
(load "2.78-tag.scm")

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(if (= (length type-tags) 2)
	  (let ((type1 (car type-tags))
		(type2 (cadr type-tags))
		(a1 (car args))
		(a2 (cadr args)))
	    (if (equal? type1 type2)
	      (error "No method for these types -- APPLY-GENERIC" (list op type-tags))
	      (let ((t1->t2 (get-coercion type1 type2))
		    (t2->t1 (get-coercion type2 type1)))
		(cons (t1->t2 (apply-generic op (t1->t2 a1) a2))
		      (t2->t1 (apply-generic op a1 (t2->t1 a2)))
		      (else (error "No method for these types -- APPLY_GENERIC" (list op type-tags))))))
	    (error "No method for these types -- APPLY-GENERIC" (list op type-tags))))))))

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
