;;; p33-smallest-divisor.scm

(define (smallest-divisor n)
    (define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
              ((divides? test-divisor n) test-divisor)
              (else (find-divisor n (+ test-divisor 1)))))
    (define (divides? a b)
        (= (remainder a b) 0))
    (find-divisor n 2))
