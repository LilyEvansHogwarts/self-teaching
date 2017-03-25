(define (inner x memo-list)
  (if (and (pair? x) (not (memq x memo-list)))
    (inner (car x) (inner (cdr x) (cons x memo-list)))
    memo-list))

(define (count-pairs x)
  (length (inner x '())))
