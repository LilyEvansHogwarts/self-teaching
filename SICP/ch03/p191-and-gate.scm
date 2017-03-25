;;;**************************************
;;;               and-gate
;;;**************************************

(define (and-gate a1 a2 output)
  (define (and-gate-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay 
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! a1 and-gate-procedure)
  (add-action! a2 and-gate-procedure)
  'Ok)

(define (logical-and a1 a2)
  (cond ((and (= a1 1) (= a2 1)) 1)
	((and (or (= a1 0) (= a1 1)) (or (= a2 0) (= a2 1))) 0)
	(else (error "Invalid signal" (list a1 a2)))))

;;;***************************************
;;;               inverter
;;;***************************************

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'Ok)

(define (logical-not s)
  (cond ((= s 0) 1)
	((= s 1) 0)
	(else (error "Invalid signal" s))))

;;;***************************************
;;;              or-gate
;;;***************************************

(define (or-gate a1 a2 output)
  (define (or-gate-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! a1 or-gate-procedure)
  (add-action! a2 or-gate-procedure)
  'Ok)

(define (logical-or a1 a2)
  (cond ((and (= a1 0) (= a2 0)) 0)
	((and (or (= a1 0) (= a1 1)) (or (= a2 0) (= a2 1))) 1)
	(else (error "Invalid signal" (list a1 a2)))))

