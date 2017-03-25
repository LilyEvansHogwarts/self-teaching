(load "2.78-put-and-get.scm")
(load "2.78-tag.scm")

(define (apply-generic op . args)
  (define tower '(scheme-number rational complex))
  (define (raise-into args1 args2 lst)
    (let ((type1 (type-tag args1))
	  (type2 (type-tag args2))
	  (current (car lst))
	  (next-lst (cdr lst)))
      (cond ((null? next-lst) current)
	    ((eq? type1 current) type2)
	    ((eq? type2 current) type1)
	    (else (raise-into args1 args2 next-lst)))))
  (define (change-type arg)
    (let ((args1 (car arg))
	  (args2 (cadr arg)))
      (let ((type1 (type-tag args1))
	    (type2 (type-tag args2))
	    (s (raise-into args1 args2 tower)))
	(cond ((and (eq? type1 type2) (eq? s type1) (eq? s type2)) (list args1 args2)) 
	      ((eq? s type1) (change-type (list args1 (raise args2))))
	      ((eq? s type2) (change-type (list (raise args1) args2)))))))


  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	(apply proc (map contents args))
	(if (= (length args) 2)
	  (let ((new-args (change-type args)))
	    (apply-generic op (car new-args) (cadr new-args)))
	  (error "No method for these types -- APPLY-GENERIC" (list op type-tags)))))))





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
