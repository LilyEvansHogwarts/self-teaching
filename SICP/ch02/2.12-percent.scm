(define (percent z)
   (let ((w (/ (- (cdr z) (car z)) 2))
         (c (/ (+ (car z) (cdr z)) 2)))
      (* (/ w c) 100)))
