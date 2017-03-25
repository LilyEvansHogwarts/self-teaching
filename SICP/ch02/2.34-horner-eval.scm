(define (horner-eval x items)
   (define (horner-eval-iter x items result)
      (let ((new-items (reverse items)))  
         (cond ((null? items) result)
               (else (horner-eval-iter x (cdr items) (+ (car items) (* result x)))))))
   (horner-eval-iter x items 0))
            
