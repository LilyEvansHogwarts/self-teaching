(define (monte-carlo trials experiment)
  (define (monte-carlo-iter trials-remain trials-passed)
    (cond ((= trials-remain 0) (/ trials-passed trials))
	  ((experiment) (monte-carlo-iter (- trials-remain 1) (+ trials-passed 1)))
	  (else (monte-carlo-iter (- trials-remain 1) trials-passed))))
  (monte-carlo-iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (in-range)
  (let ((x (random-in-range 2.0 8.0))
	(y (random-in-range 4.0 10.0)))
    (let ((key (+ (square (- x 5))
		  (square (- y 7)))))
      (<= key 9))))

(define (estimate-the-area trials)
  (let ((probability (monte-carlo trials in-range)))
    (* 36.0 probability)))