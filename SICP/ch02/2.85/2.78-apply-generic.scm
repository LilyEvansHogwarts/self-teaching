(load "2.78-put-and-get.scm")
(load "2.78-tag.scm")
(load "2.78-raise-and-drop.scm")
(define (apply-generic op . args)


  (define (apply-generic-iter op args)
    (let ((type-tags (map type-tag args)))
      (let ((proc (get op type-tags)))
	(if proc
	  (apply proc (map contents args))
	  (if (= (length args) 2)
	    (let ((new-args (change-type args)))
	      (apply-generic op (car new-args) (cadr new-args)))
	    (error "No method for these types -- APPLY-GENERIC" (list op type-tags)))))))

  (if (= (length args) 2)
    (keep-drop (apply-generic-iter op args))
    (apply-generic-iter op args)))



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

(define (raise x) (apply-generic 'raise x))

(define (drop x) (apply-generic 'drop x))
