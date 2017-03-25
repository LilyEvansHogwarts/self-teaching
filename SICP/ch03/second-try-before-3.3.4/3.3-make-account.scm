(define (make-account balance password)

  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
	     balance)
      "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (wrong-password amount)
    "Incorrect password")

  (define (dispatch p m) 
    (if (eq? p password)
      (cond ((eq? m 'withdraw)
	     withdraw)
	    ((eq? m 'deposit)
	     deposit)
	    (else (error "no such operation -- MAKE-ACCOUNT" m)))
      wrong-password))

  dispatch)
