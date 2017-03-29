(load "2.46-make-vect.scm")
(load "2.47-make-frame2.scm")
(load "2.47-origin-frame2.scm")
(load "2.47-edge1-frame2.scm")
(load "2.47-edge2-frame2.scm")
(define (test)
  (define origin (make-vect 1 1))
  (define edge1 (make-vect 2 2))
  (define edge2 (make-vect 3 3))
  (define x (make-frame origin edge1 edge2))
  (display (get-origin x))
  (newline)
  (display (get-edge1 x))
  (newline)
  (display (get-edge2 x)))