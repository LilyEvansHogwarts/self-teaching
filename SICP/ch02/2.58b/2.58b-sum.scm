(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
