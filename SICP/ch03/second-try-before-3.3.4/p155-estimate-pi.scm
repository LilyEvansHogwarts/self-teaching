(define (estimate-pi trials)
  (sqrt (/ 6 (mont-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (random) (random)) 1))

(define (mont-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
	   (/ trials-passed trials))
	  ((experiment)
	   (iter (- trials-remaining 1) (+ trials-passed 1)))
	  (else 
	    (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))
