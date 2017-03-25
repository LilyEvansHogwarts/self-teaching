(define (square-list items)
   (define nil ())
   (if (null? items)
       nil
       (cons (square (car items)) (square-list (cdr items)))))
