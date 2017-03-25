(define counter 0)

(define (make-account balance password)

  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
	     (display balance))
      (display "Insufficient funds")))

  (define (deposit amount)
    (set! balance (+ balance amount))
    (display balance))

  (define (dispatch n m)
    (if (eq? n password)
      (begin (set! counter 0)
	     (cond ((eq? m 'withdraw) withdraw)
	           ((eq? m 'deposit) deposit)
	           (else unknown-request)))
      wrong-password))

  (define (unknown-request useless-args)
    (display "Unknown request -- the legal request include: ")
    (newline)
    (display "withdraw")
    (newline)
    (display "deposit"))

  (define (wrong-password useless-args)
    (set! counter (+ counter 1))
    (if (>= counter 7)
      (display "call the cops")
      (display "security password error")))

  dispatch)
