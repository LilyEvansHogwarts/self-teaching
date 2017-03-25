(load "2.73-tag.scm")
(load "p123-put-and-get.scm")

(define (install-exponentiation-package)
  ;;internal procedure
  (define (base z) (car z))
  (define (exponent z) (cadr z))
  (define (make-exp x n)
    (cond ((= n 0) 1)
	  ((= n 1) x)
	  (else (attach-tag '** x n))))

  ;;interface to the rest of the system
  (put 'base '** base)
  (put 'exponent '** exponent)
  (put 'make-exp '** make-exp)
  (put 'deriv '** (lambda (expression var)
		      (make-product (exponent expression)
				    (make-exp (base expression) (- (exponent expression) 1)))))
  'done)

(define (base sum)
  ((get 'base '**) (contents sum)))

(define (exponent sum)
  ((get 'exponent '**) (contents sum)))

(define (make-exp x y)
  ((get 'make-exp '**) x y))
