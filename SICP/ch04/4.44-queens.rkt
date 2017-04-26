#lang swindle

(define (safe? items)
  (let ((p (car items)))
    (define (conflict? q i)
      (or (= p q) (= p (- q i)) (= p (+ q i))))
    (define (check? rest i)
      (cond ((null? rest) true)
            ((conflict? (car rest) i) false)
            (else (check? (cdr rest) (+ i 1)))))
    (check? (cdr items) 1)))

(define (require p)
  (if (not p) (amb)))

(define (an-integer-between a b)
 (require (<= a b))
 (amb a (an-integer-between (+ a 1) b)))

(define (queens n)
 (define (iter solution i)
  (if (= i n)
   solution
   (let ((x (an-integer-between 1 n)))
	(let ((new-solution (cons x solution)))
	 (require (safe? new-solution))
         (iter new-solution (+ i 1))))))
 (iter '() 0))


