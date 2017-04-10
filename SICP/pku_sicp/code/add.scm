;;(define (add x y . rest)
;; (define (iter result lst)
;;  (cond ((null? lst) result)
;;	    (else (iter (+ result (car lst)) (cdr lst)))))
;; (iter (+ x y) rest))

(define (add x y . rest)
 (cond ((null? rest) (+ x y))
  (else (apply add (cons (+ x y) rest)))))
