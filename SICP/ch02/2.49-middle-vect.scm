(load "2.46-add-vect.scm")
(load "2.46-scale-vect.scm")
(define (middle-vect a b)
  (scale-vect 0.5 (add-vect a b)))
