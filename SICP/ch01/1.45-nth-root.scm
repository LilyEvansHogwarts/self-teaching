(load "1.45-damped-nth-root.scm")

(define (nth-root x n)
   ((damped-nth-root n (ceiling (log x))) x))
