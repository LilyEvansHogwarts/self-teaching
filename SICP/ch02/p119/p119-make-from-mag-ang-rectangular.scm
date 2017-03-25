(load "p119-attach-tag.scm")
(define (make-from-magnitude-angle-rectangular r a)
  (attach-tag 'rectangular (cons (* r (cos a)) (* r (sin a)))))
