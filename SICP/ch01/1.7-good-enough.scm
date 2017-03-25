(define (good-enough? guess x)
   (< (abs (/ (abs (- (square guess) x)) guess)) 0.001))
