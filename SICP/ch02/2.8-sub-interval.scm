(load "2.7-make-interval.scm")
(load "2.7-lower-bound.scm")
(load "2.7-upper-bound.scm")

(define (sub-interval x y)
   (make-interval (- (lower-bound x) (upper-bound y))
                  (- (upper-bound x) (lower-bound y))))
