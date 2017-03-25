(define (filtered f combiner null-value term a next b)
   (cond ((> a b) null-value)
         ((f a) (combiner (term a) (filtered f combiner null-value term (next a) next b)))
         (else (filtered f combiner null-value term (next a) next b))))
       
