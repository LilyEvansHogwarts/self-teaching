(load "p44-search.scm")

(define (half-interval-method f a b)
   (let ((a-value (f a))
         (b-value (f b)))
        (cond ((= a-value 0) a)
              ((= b-value 0) b)
              ((and (< a-value 0) (> b-value 0)) (search f a b))
              ((and (> a-value 0) (< b-value 0)) (search f b a))
              (else (error "Values are not of opposite sign" a b)))))

