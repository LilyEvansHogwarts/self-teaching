(load "2.73-tag.scm")
(load "p123-put-and-get.scm")

(define (install-sum-package)
  ;;internal procedures
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (make-sum a1 a2)
    (cond ((and (number? a1) (= a1 0)) a2)
	  ((and (number? a2) (= a2 0)) a1)
	  ((and (number? a1) (number? a2)) (+ a1 a2))
	  (else (attach-tag '+ a1 a2))))

  ;;interface to the rest of the system
  (put 'addend '+ addend)
  (put 'augend '+ augend)
  (put 'make-sum '+ make-sum)
  (put 'deriv '+ (lambda (expression var)
		   (make-sum (deriv (addend expression) var)
			     (deriv (augend expression) var))))
  'done)

(define (addend sum)
  ((get 'addend '+) (contents sum)))

(define (augend sum)
  ((get 'augend '+) (contents sum)))

(define (make-sum x y)
  ((get 'make-sum '+) x y))
