(load "2.78-put-and-get.scm")
(load "2.78-tag.scm")

(define (install-polar-package)

  ;;internal procedures
  (define (magnitude_ z) (car z))
  (define (angle_ z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part_ z) (* (magnitude_ z) (cos (angle_ z))))
  (define (imag-part_ z) (* (magnitude_ z) (sin (angle_ z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y))) (atan y x)))
  
  ;;interface to the rest of the system
  (define (tag z) (attach-tag 'polar z))
  (put 'real_part_ '(polar) real-part_)
  (put 'imag-part_ '(polar) imag-part_)
  (put 'magnitude_ '(polar) magnitude_)
  (put 'angle_ '(polar) angle_)
  (put 'make-from-real-imag 'polar (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))
