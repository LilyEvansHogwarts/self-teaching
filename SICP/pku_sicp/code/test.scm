(define make-counter
 (lambda (n)
  (lambda ()
   (set! n (+ n 1))
   n)))

(define ca (make-counter 0))
(define cb (make-counter 0))

;;***********************************

(define (haha)
 (let ((a 1))
  (define (f x)
   (define a 5)
   (define b (+ a x))
   (+ a b))
  (f 10)))
