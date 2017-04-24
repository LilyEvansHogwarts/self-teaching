(load "lazy-eval.scm")

(define haha '(begin (car '(a b c))))
(interpret haha)
