(load "p180-queue.scm")

;;;***********************************************
;;;                   gate
;;;***********************************************

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! input invert-input))

(define (logical-not x)
  (cond ((= x 0) 1)
	((= x 1) 0)
	(else (error "Invalid signal" x))))

(define (and-gate a1 a2 output)
  (define (and-gate-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! a1 and-gate-procedure)
  (add-action! a2 and-gate-procedure))

(define (logical-and a1 a2)
  (cond ((and (= a1 1) (= a2 1)) 1)
	(else 0)))

(define (or-gate a1 a2 output)
  (define (or-gate-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
		   (lambda ()
		     (set-signal! output new-value)))))
  (add-action! a1 or-gate-procedure)
  (add-action! a2 or-gate-procedure))

(define (logical-or a1 a2)
  (cond ((and (= a1 0) (= a2 0)) 0)
	(else 1)))

;;;***********************************************
;;;                  make-wire
;;;***********************************************

(define (make-wire)
  (let ((signal-value 0)
	(action-procedures '()))
    (define (set-my-signal! new-value)
      (if (= signal-value new-value)
	'done
	(begin (set! signal-value new-value)
	       (call-each action-procedures))))
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
	    ((eq? m 'set-signal!) set-my-signal!)
	    ((eq? m 'add-action!) accept-action-procedure!)
	    (else (error "Unknown operation -- WIRE" m))))
    dispatch))

(define (call-each procedures)
  (if (null? procedures)
    'done
    (begin ((car procedures))
	   (call-each (cdr procedures)))))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire action)
  ((wire 'add-action!) action))

;;;***********************************************
;;;                   make-agenda
;;;***********************************************

(define (make-agenda) (list 0))

(define (current-time agenda) (car agenda))

(define (segments agenda) (cdr agenda))

(define (set-current-time! agenda time)
  (set-car! agenda time))

(define (set-segments! agenda segments)
  (set-cdr! agenda segments))

(define (first-segment agenda) (car (segments agenda)))

(define (rest-segments agenda) (cdr (segments agenda)))

(define (empty-agenda? agenda)
  (null? (segments agenda)))

(define (make-time-segment time queue)
  (cons time queue))

(define (segment-time s) (car s))

(define (segment-queue s) (cdr s))

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
    (or (null? segments)
	(< time (segment-time (car segments)))))
  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))
  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
      (insert-queue! (segment-queue (car segments)) action)
      (let ((rest (cdr segments)))
	(if (belongs-before? rest)
	  (set-cdr! segments (cons (make-new-time-segment time action) (cdr segments)))
	  (add-to-segments! rest)))))

  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
      (set-segments! agenda (cons (make-new-time-segment time action) segments))
      (add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
      (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
    (error "Agenda is empty -- FIRST-AGENDA-ITEM" agenda)
    (let ((first-seg (first-segment agenda)))
      (set-current-time! agenda (segment-time first-seg))
      (front-queue (segment-queue first-seg)))))

;;;**********************************************************************
;;;                   after-delay   propagate   probe
;;;**********************************************************************

(define the-agenda (make-agenda))

(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
		  action
		  the-agenda))

(define (propagate)
  (if (empty-agenda? the-agenda)
    'done
    (let ((first-item (first-agenda-item the-agenda)))
      (first-item)
      (remove-first-agenda-item! the-agenda)
      (propagate))))

(define (probe name wire)
  (add-action! wire
	       (lambda ()
		 (newline)
		 (display name)
		 (display " ")
		 (display (current-time the-agenda))
		 (display "  New-value =  ")
		 (display (get-signal wire)))))

;;;*******************************************************************
;;;            half-adder  full-adder  ripple-carry-adder
;;;*******************************************************************

(define (half-adder a b s c)
  (let ((d (make-wire))
	(e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)))

(define (full-adder a b c-in sum c-out)
  (let ((c1 (make-wire))
	(c2 (make-wire))
	(s (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)))

(define (ripple-carry-adder A B S C)
  (define (iter A B S value-of-c)
    (if (and (null? A) (null? B) (null? S))
      'done
      (let ((Ak (car A))
	   (Bk (car B))
	   (Sk (car S))
	   (remain-A (cdr A))
	   (remain-B (cdr B))
	   (remain-S (cdr S))
	   (Ck (make-wire)))
	(set-signal! Ck value-of-c)
	(full-adder Ak Bk Ck Sk C)
	(iter remain-A remain-B remain-S (get-signal C)))))
  (iter A B S (get-signal C)))

;;;******************************************************************
;;;                             test
;;;******************************************************************
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define a1 (make-wire))
(define a2 (make-wire))
(define a3 (make-wire))
(define a4 (make-wire))
(define a5 (make-wire))
(define a6 (make-wire))

(define b1 (make-wire))
(define b2 (make-wire))
(define b3 (make-wire))
(define b4 (make-wire))
(define b5 (make-wire))
(define b6 (make-wire))

(define s1 (make-wire))
(define s2 (make-wire))
(define s3 (make-wire))
(define s4 (make-wire))
(define s5 (make-wire))
(define s6 (make-wire))

(define c (make-wire))

(set-signal! a2 1)
(set-signal! a4 1)
(set-signal! a6 1)

(set-signal! b1 1)
(set-signal! b3 1)
(set-signal! b5 1)
(set-signal! b6 1)

(ripple-carry-adder (list a1 a2 a3 a4 a5 a6)
		    (list b1 b2 b3 b4 b5 b6)
		    (list s1 s2 s3 s4 s5 s6)
		    c)

(propagate)

(probe 's1 s1)
(probe 's2 s2)
(probe 's3 s3)
(probe 's4 s4)
(probe 's5 s5)
(probe 's6 s6)
(probe 'c c)
