(load "1.45-damped-nth-root.scm")

(define (test n damped-times x)
   ((damped-nth-root n damped-times) x))
