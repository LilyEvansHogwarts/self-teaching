#lang swindle
 
(define (require p)
  (if (not p) (amb)))

(define (an-integer-between low high)
 (require (<= low high))
 (amb low (an-integer-between (+ low 1) high)))

(define (square x) (* x x))

(define (a-pythagorean-triple-between low high)
 (let ((i (an-integer-between low high))
       (hsq (* high high)))
  (let ((j (an-integer-between i high)))
   (let ((ksq (+ (square i) (square j))))
	(require (>= hsq ksq))
	(let ((k (sqrt ksq)))
	 (require (integer? k))
	 (list i j k))))))

;;;(a-pythagorean-triple-between 1 10)
;;;(a-pythagorean-triple-between 5 20)
;;;(a-pythagorean-triple-between 9 20)
;;;(a-pythagorean-triple-between 39 100)
