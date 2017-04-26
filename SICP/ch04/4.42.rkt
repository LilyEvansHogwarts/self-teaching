#lang swindle

(define (distinct? items)
 (cond ((null? items) true)
	   ((null? (cdr items)) true)
	   ((member (car items) (cdr items)) false)
	   (else (distinct? (cdr items)))))

(define (choose a b)
 (require (or (and a (not b))
			  (and b (not a)))))

(define (require p)
 (if (not p) (amb)))

(define (ranking)
 (let ((betty (amb 1 2 3 4 5))
	   (ethel (amb 1 2 3 4 5))
	   (joan (amb 1 2 3 4 5))
	   (kitty (amb 1 2 3 4 5))
	   (mary (amb 1 2 3 4 5)))
  (choose (= kitty 2) (= betty 3))
  (choose (= ethel 1) (= joan 2))
  (choose (= joan 3) (= ethel 5))
  (choose (= kitty 2) (= mary 4))
  (choose (= mary 4) (= betty 1))
  (require (distinct? (list betty ethel joan kitty mary)))
  (list (list 'betty betty)
	    (list 'ethel ethel)
		(list 'joan joan)
		(list 'kitty kitty)
		(list 'mary mary))))

;;;((betty 3) (ethel 5) (joan 2) (kitty 1) (mary 4))