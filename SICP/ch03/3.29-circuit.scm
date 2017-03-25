(define (half-adder a b s c)
  (let ((d (make-wire))
	(e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
	(c1 (make-wire))
	(c2 (make-wire)))
    (half-adder a b s c1)
    (half-adder s c-in sum c2)
    (and-gate c1 c2 c-out)))

;;;****************************************
;;;inverter

(define (inverter input output)
  (define (inverter-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! input invert-input))

(define (logical-not s)
  (cond ((= s 0) 1)
	((= s 1) 0)
	(else (error "Invalid signal" s))))
 
;;;****************************************
;;;and-gate

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay 
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure))

(define (logical-and a1 a2)
  (cond ((or (= a1 0) (= a2 0)) 0)
	((and (= a1 1) (= a2 1)) 1)
	(else (error "Invalid signal" (list a1 a2)))))

;;;****************************************
;;;or-gate

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2)))
	  (or-gate-delay (+ inverter-delay inverter-delay and-gate-delay)))
      (after-delay or-gate-delay 
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure))

(define (logical-or a1 a2)
  (cond ((and (or (= a1 0) (= a1 1)) (or (= a2 0) (= a2 1))) 
	 (logical-not (logical-and (logical-not a1) (logical-not a2))))
	(else (error "Invalid signal" (list a1 a2)))))


