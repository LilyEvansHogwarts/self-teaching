;;;**********************************************************
;;;         this part is from 3.4-make-account.scm
;;;**********************************************************

(define (make-account balance password)

  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
	     balance)
      "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)



  (define (dispatch p m) 
    (if (eq? p password)
      (begin (set! count 0)
	     (cond ((eq? m 'withdraw)
	            withdraw)
	           ((eq? m 'deposit)
	            deposit)
	           (else (error "no such operation -- MAKE-ACCOUNT" m))))
      wrong-password))

  dispatch)

(define count 0)
  
(define (wrong-password amount)
  (set! count (+ count 1))
  (if (<= count 7)
    "Incorrect password"
    "call the cops"))

;;;*****************************************
;;;         the part that is added
;;;*****************************************

(define (make-joint name password new-password)
  (define (dispatch p m)
    (if (eq? p new-password)
      (cond ((eq? m 'withdraw) (name password 'withdraw))
	    ((eq? m 'deposit) (name password 'deposit))
	    (else (error "no such operation -- MAKE-JOINT" m)))
      wrong-password))
  dispatch)

