(load "1.8-improve.scm")
(load "1.8-good-enough.scm")

(define (cube-root guess x)
  (if (good-enough? guess x)
      guess
      (cube-root (improve guess x) x)))

