(define (fold-left_ op initial items)
   (cond ((null? items) initial)
         (else (fold-left_ op (op initial (car items)) (cdr items)))))
