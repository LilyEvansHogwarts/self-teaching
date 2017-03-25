(load "1.22-continue-primes.scm")

(define (search-for-primes n)
   (define (start-prime-time n start-time)
      (continue-primes n 3)
      (report-time (- (real-time-clock) start-time)))
   (define (report-time elapsed-time)
      (display " *** ")
      (display elapsed-time))
   (display "The smallest three prime number are ")
   (display n)
   (newline)
   (start-prime-time n (real-time-clock)))



