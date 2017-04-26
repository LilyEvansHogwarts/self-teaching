#lang swindle

(define (require p)
   (if (not p) (amb)))
  
(define (distinct? items)
  (define (iter y xs)
  (cond ((null? xs) (distinct? (cdr items)))
             ((eq? (car xs) y) false)
            (else (iter y (cdr xs)))))
    (if (null? items)
        true
       (let ((y (car items)))
          (iter y (cdr items)))))

(define (multiple-dwelling-1)
  (let ((baker (amb 1 2 3 4))
        (cooper (amb 2 3 4 5))
        (miler (amb 1 2 3 4 5))
        (fletcher (amb 2 3 4))
        (smith (amb 1 2 3 4 5)))
    (require (> miler cooper))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (distinct? (list baker cooper fletcher miler smith)))))

(define (multiple-dwelling-2)
  (let ((miler (amb 1 2 3 4 5))
        (cooper (amb 2 3 4 5)))
    (require (> miler cooper))
    (let ((fletcher (amb 2 3 4)))
      (require (not (= (abs (- fletcher cooper)) 1)))
      (let ((smith (amb 1 2 3 4 5)))
        (require (not (= (abs (- smith fletcher)) 1)))
        (let ((baker (amb 1 2 3 4)))
          (require (distinct? (list baker cooper fletcher miler smith))))))))

(define tests 100)

(collect-garbage)
(time 
 (let next ((x tests))
   (cond ((zero? x) 'done)
         (else (multiple-dwelling-1)
               (next (- x 1))))))

(collect-garbage)
(time 
 (let next ((x tests))
   (cond ((zero? x) 'done)
         (else (multiple-dwelling-2)
               (next (- x 1))))))

