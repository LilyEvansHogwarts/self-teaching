(define (prime-sum-pairs n)
   (define (accumulate op initial items)
      (cond ((null? items) initial)
            (else (accumulate op (op (car items) initial) (cdr items)))))
   (define (prime? n)
      (= (smallest-divisor n) n))
   (define (smallest-divisor n)
      (smallest-divisor-iter n 2))
   (define (smallest-divisor-iter n test-divisor)
      (cond ((> (square test-divisor) n) n)
            ((divides? n test-divisor) test-divisor)
            (else (smallest-divisor-iter n (next test-divisor)))))
   (define (divides? n test-divisor)
      (= 0 (remainder n test-divisor)))
   (define (next n)
      (if (even? n)
          (+ n 1)
          (+ n 2)))
   (define (enumerate-interval low high)
      (cond ((> low high) ())
            (else (cons low (enumerate-interval (+ low 1) high)))))
   (let ((items (accumulate append () (map (lambda (i) (map (lambda (j) (list j i)) (enumerate-interval 1 (- i 1)))) (enumerate-interval 1 n)))))
      (map (lambda (x) (append x (cons (+ (car x) (cadr x)) ()))) (filter (lambda (x) (prime? (+ (car x) (cadr x)))) items))))