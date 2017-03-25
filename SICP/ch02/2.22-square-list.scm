(define (square-list items)
   (define nil ())
   (define (square-list-iter items result)
      (if (null? items)
          result
          (square-list-iter (cdr items) (append result (list (square (car items)))))))
   (square-list-iter items nil))
