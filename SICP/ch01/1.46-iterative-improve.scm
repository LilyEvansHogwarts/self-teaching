(define (iterative-improve enough improve)
   (lambda (first-guess) 
      (define (try guess)
         (let ((next (improve guess)))
            (if (enough guess next)
                next
                (try next))))
      (try first-guess)))
