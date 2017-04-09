(define make-counter
 (lambda (n)
  (lambda ()
   (set! n (+ n 1))
   n)))

(define ca (make-counter 0))
(define cb (make-counter 0))
