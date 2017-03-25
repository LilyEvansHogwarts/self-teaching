(define (reverse_ items)
   (define nil ())
   (let ((rest (cdr items)))
      (if (null? rest)
          items
          (append (reverse_ rest) (cons (car items) nil)))))
