(load "p93-segment-painter.scm")
(load "2.46-make-vect.scm")
(load "p93-segment-painter.scm")
(define (cross)
  (define top-left (make-vect 0.0 1.0))
  (define top-right (make-vect 1.0 1.0))
  (define bottom-left (make-vect 0.0 0.0))
  (define bottom-right (make-vect 1.0 0.0))
  (define cross1 (make-segment top-left bottom-right))
  (define cross2 (make-segment top-right bottom-left))
  (define segment-list (list cross1 cross2))
  (segments->painter segment-list))
