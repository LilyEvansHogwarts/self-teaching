(define (square-tree x)
   (define nil ())
   (cond ((null? x) nil)
         ((not (pair? x)) (square x))
         (else (cons (square-tree (car x)) (square-tree (cdr x))))))