(load "p38-high-order-sum.scm")

(define (simpson-sum a b n)
   (define h (/ (- b a) n))
   (define (cube n) (* n n n))
   (define (inc n) (+ n 1))
   (define (f n) (+ a (* h n)))
   (define (term k)
      (cond ((or (= k 0) (= k n)) (cube (f k)))
            ((even? k) (* 2 (cube (f k))))
            (else (* 4 (cube (f k))))))
   (* (sum term 0 inc n) (/ h 3)))
