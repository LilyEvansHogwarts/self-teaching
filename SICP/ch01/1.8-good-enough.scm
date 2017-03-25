(define (good-enough? guess x)
   (< (abs (- (* guess guess guess) x)) 0.001))
