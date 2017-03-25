(define (make-center-percent c p)
   (let ((p1 (/ (* c p) 100)))
      (cons (- c p1) (+ c p1))))
