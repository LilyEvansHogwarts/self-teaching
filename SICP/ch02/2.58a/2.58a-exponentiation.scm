(define (exponentiation? x)
  (and (pair? x) (eq? (cadr x) 'expt)))
