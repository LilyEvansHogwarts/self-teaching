(define (make-accumulator balance)
  (lambda (amount)
    (set! balance (+ balance amount))
    balance))
