(load "p123-put-and-get.scm")
(load "p119-tag.scm")

(define (install-rectangular-package)

  ;;internal procedures
  (define (real-part_ z) (car z))
  (define (imag-part_ z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude_ z ) 
    (sqrt (+ (square (real-part_ z))
	     (square (imag-part_ z)))))
  (define (angle_ z)
    (atan (imag-part_ z) (real-part_ z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))

  ;;interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part_ '(rectangular) real-part_)
  (put 'imag-part_ '(rectangular) imag-part_)
  (put 'magnitude_ '(rectangular) magnitude_)
  (put 'angle_ '(rectangular) angle_)
  (put 'make-from-real-imag 'rectangular (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
