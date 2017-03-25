(define (make-accumulator balance)
  (lambda (x)
    (set! balance (+ x balance))
    balance))
