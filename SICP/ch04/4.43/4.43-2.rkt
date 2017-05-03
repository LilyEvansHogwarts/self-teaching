#lang swindle

(define (require p)
  (if (not p) (amb)))

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (sailors)
 (define father first)
 (define daughter second)
 (define yachet third)
 (define (different-names father)
  (not (eq? (daughter father) (yachet father))))
 (let ((moore (list 'moore (amb 'gabrielle 'rosalind 'mary) 'lorna))
	   (downing (list 'downing (amb 'gabrielle 'lorna 'rosalind 'mary) 'melissa))
	   (hall (list 'hall (amb 'gabrielle 'lorna 'mary) 'rosalind))
	   (barnacle (list 'barnacle 'melissa 'gabrielle))
	   (parker (list 'parker (amb 'gabrielle 'lorna 'rosalind) 'mary)))
  (let* ((gabrielle-father (amb moore downing hall parker))
		(lorna-father (amb moore downing hall parker))
		(mary-father (amb moore downing hall))
        (rosalind-father (amb moore downing parker))
		(fathers (list moore downing hall barnacle parker))
		(daughters (map daughter fathers)))
 ;;;  (require (distinct? daughters))
   (require (eq? (daughter gabrielle-father) 'gabrielle))
   (require (eq? (daughter lorna-father) 'lorna))
   (require (eq? (daughter mary-father) 'mary))
   (require (eq? (daughter rosalind-father) 'rosalind))
   (require (eq? (daughter parker) (yachet gabrielle-father)))
   fathers)))

;;;增加一个 (require (eq? (daughter rosalind-father) 'rosalind))条件效果与(require (distinct? daughters))一致