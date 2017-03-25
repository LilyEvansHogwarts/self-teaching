;;;修改的部分
(define (application? exp) (tagged-list? exp 'call))

(define (operator exp) (cadr exp))

(define (operands exp) (cddr exp))

;;;test
;;;(define (append x y)
;;;  (if (call null? x)
;;;    y
;;;    (call cons (call car x) (call append (call cdr x) y))))

;;;(call append '(a b c) '(e f g))
