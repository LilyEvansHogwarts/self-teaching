(define (fringe x)
   (define nil ())
   (define (fringe-iter x result)
      (cond ((null? x) result)
            ((not (pair? x)) (cons x result))
            (else (fringe-iter (car x) (fringe-iter (cdr x) result)))))
   (fringe-iter x nil))
          
