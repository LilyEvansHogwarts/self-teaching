(load "2.78-tag.scm")
(load "2.78-put-and-get.scm")

(define (install-rational-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d) 
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
		 (* (numer y) (denom x)))
	      (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
		 (* (numer y) (denom x)))
	      (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
	      (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
	      (* (numer y) (denom x))))
  
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  (put 'equ? '(rational rational)
       (lambda (x y) (and (= (numer x) (numer y))
			  (= (denom x) (denom y)))))
  (put '=zero? '(rational)
       (lambda (x) (and (= (numer x) 0) (= (denom x) 0))))
  (put 'raise '(rational) 
       (lambda (x) (make-complex-from-real-imag (/ (numer x) (denom x)) 0)))
  (put 'drop '(rational)
       (lambda (x) (if (= (denom x) 1) (make-scheme-number (numer x)) x)))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))
