(define (make-account balance password)

  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
	     balance)
      "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch n m)
    (if (eq? n password)
      (cond ((eq? m 'withdraw) withdraw)
	    ((eq? m 'deposit) deposit)
	    (else (error "Unknown request -- MAKE-ACCOUNT" m)))
      wrong-password))

  dispatch)

(define (make-joint username passwd new-passwd)
  (lambda (s mode)
    (if (eq? s new-passwd)
      (username passwd mode)
      wrong-password)))


(define (wrong-password useless-args)
  (display "Incorrect password."))