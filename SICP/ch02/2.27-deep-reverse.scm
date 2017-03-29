(define (deep-reverse x)
   (define nil ())
   (define (count-leaves items)
      (cond ((null? items) 0)
            ((not (pair? items)) 1)
            (else (+ (count-leaves (car items)) (count-leaves (cdr items))))))
   (define (deep-reverse-iter x k result )
      (if (= k 0)
          (cons (deep-reverse (list-ref x k)) result)
          (deep-reverse-iter x (- k 1) (cons (deep-reverse (list-ref x k)) result))))
   (let ((n (length x)))
      (cond ((null? x) nil)
            ((= (length x) (count-leaves x)) (reverse x))
            (else (reverse (deep-reverse-iter x (- n 1) nil)))))) 