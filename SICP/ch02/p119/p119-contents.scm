(define (contents datum)
  (if (pair? datum)
    (cdr contents)
    (error "Bad tagged datum -- CONTENTS" datum)))
