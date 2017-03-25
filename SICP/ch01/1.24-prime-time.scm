(load "1.24-continue-primes.scm")

(define (timed-prime-test n)
   (define (start-prime-test n start-time)
      (continue-primes n 12)
      (report-prime (- (real-time-clock) start-time)))
   (define (report-prime elapsed-time)
      (display " *** ")
      (display elapsed-time))
   (start-prime-test n (real-time-clock)))

   


