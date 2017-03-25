(load "2.7-make-interval.scm")
(load "2.7-lower-bound.scm")
(load "2.7-upper-bound.scm")
(define (mul-interval x y)
   (let ((x1 (lower-bound x))
         (x2 (lower-bound y))
         (y1 (upper-bound x))
         (y2 (upper-bound y)))
        (cond ((and (>= x1 0) (>= x2 0) (> y1 0) (> y2 0)) (make-interval (* x1 x2) (* y1 y2)));;;+ + + +
              ((and (>= x1 0) (<= x2 0) (> y1 0) (>= y2 0)) (make-interval (* x1 x2) (* y1 y2)));;;+ - + +
              ((and (>= x1 0) (< x2 0) (> y1 0) (<= y2 0)) (make-interval (* x1 x2) (* y1 y2)));;;+ - + -
              ((and (<= x1 0) (>= x2 0) (>= y1 0) (> y2 0)) (make-interval (* x1 x2) (* y1 y2)));;;- + + +
              ((and (> x1 0) (>= x2 0) (<= y1 0) (> y2 0)) (make-interval (* x1 x2) (* y1 y2)));;;- + - +
              ((and (>= x1 0) (>= x2 0) (> y1 0) (> y2 0)) (let ((p1 (* x1 x2))
                                                                 (p2 (* y1 y2)))
                                                                (make-interval (min p1 p2) (max p1 p2))));;;- - + +
              ((and (<= x1 0) (< x2 0) (>= y1 0) (<= y2 0)) (make-interval (* y1 x2) (* x1 x2)));;;- - + -                  
              ((and (< x1 0) (<= x2 0) (<= y1 0) (>= y2 0)) (make-interval (* x1 y2) (* x1 x2)));;;- - - +
              (else (make-interval (* y1 y2) (* x1 x2))))));;;- - - -
