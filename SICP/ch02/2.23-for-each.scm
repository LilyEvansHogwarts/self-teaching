(define (for-each_ f items)
   (define nil ())
   (if (null? items)
       nil
       (begin (f (car items))
              (for-each_ f (cdr items)))))
