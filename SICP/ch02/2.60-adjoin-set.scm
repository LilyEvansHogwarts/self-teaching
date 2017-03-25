(define (adjoin-set x set)
  (if (null? set)
    (list x)
    (cons x set)))
