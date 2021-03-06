(define (reverse_ items)
   (define (fold-right_ op initial items)
      (cond ((null? items) initial)
            (else (fold-right_ op (op (car items) initial) (cdr items)))))
   (fold-right_ (lambda (x y) (cons x y)) () items))
