(define (split first second)
  (lambda (painter) (first painter (second painter painter))))
