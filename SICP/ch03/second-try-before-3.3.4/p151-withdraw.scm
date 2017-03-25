(define balance 1000)

(define (withdraw amount)
  (if (>= balance amount)
    (begin (set! balance (- balance amount))
	   balance)
    "Insufficient funds"))

