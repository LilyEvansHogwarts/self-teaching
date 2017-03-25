(define (divider a b c)
  (define (process-new-value)
    (cond ((and (has-value? b) (= 0 (get-value b)))
	   (error "the divider is 0 -- DIVIDER" b))
	  ((and (has-value? c) (= 0 (get-value c)))
	   (error "the divider is 0 -- DIVIDER" c))
	  ((and (has-value? a) (has-value? b))
	   (set-value! c (/ (get-value a) (get-value b)) me))
	  ((and (has-value? a) (has-value? c))
	   (set-value! b (/ (get-value a) (get-value c)) me))
	  ((and (has-value? b) (has-value? c))
	   (set-value! a (* (get-value b) (get-value c)) me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (forget-value! c me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
	   (process-new-value))
	  ((eq? request 'I-lost-my-value)
	   (process-forget-value))
	  (else
	    (error "Unknown request -- DIVIDER" request))))
  (connect a me)
  (connect b me)
  (connect c me)
  me)
