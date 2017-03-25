;;;********************************************
;;;                  make-wire
;;;********************************************

(define (make-wire)
  (let ((signal-value 0)
	(action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
	(begin (set! signal-value new-value)
	       (call-each action-procedures))
	'done))

    (define (accept-action-procedure! proc)
      (let ((new-pair (cons proc '())))
	(if (null? action-procedures)
	  (set! action-procedures new-pair)
	  (set-cdr! (last-pair action-procedures) new-pair)))
      (proc))

    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
	    ((eq? m 'set-signal!) set-my-signal!)
	    ((eq? m 'add-action!) accept-action-procedure!)
	    (else (error "Unknown operation -- WIRE" m))))
    dispatch))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

;;;********************************************
;;;                 call-each
;;;********************************************

(define (call-each procedures)
  (if (null? procedures)
    'done
    (begin ((car procedures))
	   (call-each (cdr procedures)))))

(define (last-pair lst)
  (if (null? (cdr lst))
    lst
    (last-pair (cdr lst))))
