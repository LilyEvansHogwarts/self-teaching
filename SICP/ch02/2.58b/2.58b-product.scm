(define (product? x) 
  (and (pair? x) (eq? (cadr x) '*)))
