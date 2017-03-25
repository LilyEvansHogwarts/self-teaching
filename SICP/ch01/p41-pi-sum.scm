(load "p38-high-order-sum.scm")

(define (pi-sum a b)
   (sum (lambda (x) (/ 1 (* x (+ x 2))))
        a 
        (lambda (x) (+ x 4))
        b))
