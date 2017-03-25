(define (inner x element)
  (if (and (pair? x) (not (memq x element))) 
    (inner (car x) (inner (cdr x) (cons x element)))
    element))

(define (count-pairs x)
  (length (inner x '())))
