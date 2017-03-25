(define (estimate-pi trials)
  (sqrt (/ 6 (random-gcd-test trials random-init))))

(define (random-gcd-test trials initial-x)
  (define (iter trials-remaining trials-passed x)
    (let ((x1 (rand-update x)))
      (let ((x2 (rand-update x)))
	(cond ((= trials-remaining 0) 
	       (/ trials-remaining trials-passed))
	      ((= (gcd x1 x2) 1)
	       (iter (- trials-remaining 1) (+ trials-passed 1) x2))
	      (else
		(iter (- trials-remaining 1) trials-passed x2))))))
  (iter trials 0 initial-x))
