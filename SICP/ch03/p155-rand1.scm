(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials experiment)
  (define (monte-carlo-iter trials-remain trials-passed)
    (cond ((= trials-remain 0) (/ trials-passed trials))
	  ((experiment) (monte-carlo-iter (- trials-remain 1) (+ trials-passed 1)))
	  (else (monte-carlo-iter (- trials-remain 1) trials-passed))))
  (monte-carlo-iter trials 0))

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))
