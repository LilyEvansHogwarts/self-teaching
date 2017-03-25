(load "2.73-tag.scm")
(load "p123-put-and-get.scm")

(define (install-product-package)
  ;;internal procedures
  (define (multiplier z) (car z))
  (define (multiplicand z) (cadr z))
  (define (make-product x y)
    (cond ((or (and (number? x) (= x 0)) (and (number? y) (= y 0))) 0)
	  ((and (number? x) (= x 1)) y)
	  ((and (number? y) (= y 1)) x)
	  ((and (number? x) (number? y)) (* x y))
	  (else (attach-tag '* x y))))

  ;;interface to the rest of te system
  (put 'multiplier '* multiplier)
  (put 'multiplicand '* multiplicand)
  (put 'make-product '* make-product)
  (put 'deriv '* (lambda (expression var) 
		   (make-sum (make-product (deriv (multiplier expression) var)
					   (multiplicand expression))
			     (make-product (multiplier expression)
					   (deriv (multiplicand expression) var)))))
  'done)

(define (multiplier sum)
  ((get 'multiplier '*) (contents sum)))

(define (multiplicand sum)
  ((get 'multiplicand '*) (contents sum)))

(define (make-product x y)
  ((get 'make-product '*) x y))
