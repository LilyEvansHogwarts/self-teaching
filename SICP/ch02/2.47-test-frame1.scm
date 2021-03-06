(load "2.47-make-frame1.scm")
(load "2.46-make-vect.scm")
(load "2.47-origin-frame1.scm")
(load "2.47-edge1-frame1.scm")
(load "2.47-edge2-frame1.scm")
;;;this program test the runability of make and get function
(define (test)
  (define origin (make-vect 1 1))
  (define edge1 (make-vect 2 2))
  (define edge2 (make-vect 3 3))
  (define frame (make-frame origin edge1 edge2))
  (display (get-origin frame))
  (newline)
  (display (get-edge1 frame))
  (newline)
  (display (get-edge2 frame)))
