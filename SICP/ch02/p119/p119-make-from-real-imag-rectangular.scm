(load "p119-attach-tag.scm")
(define (make-from-real-imag-rectangular a b)
  (attach-tag 'rectangular (cons a b)))
