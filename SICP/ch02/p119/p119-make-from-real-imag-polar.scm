(load "p119-attach-tag.scm")
(define (make-from-real-imag-polar x y)
  (attach-tag 'polar (cons (sqrt (+ (square x) (square y))) (atan y x))))
