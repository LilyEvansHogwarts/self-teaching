(define (fold-right_ op initial items)
   (cond ((null? items) initial)
         (else (fold-right_ op (op (car items) initial) (cdr items)))))
