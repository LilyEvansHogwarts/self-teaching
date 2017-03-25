(define (attach-tag type-tag x y)
  (list type-tag x y))

(define (type-tag z)
  (if (pair? z)
    (car z)
    (error "Bad tagged z -- TYPY-TAG" z)))

(define (contents z)
  (if (pair? z)
    (cdr z)
    (error "Bad tagged z -- CONTENTS" z)))
