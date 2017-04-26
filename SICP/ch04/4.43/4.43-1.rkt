#lang swindle

(define (require p)
  (if (not p) (amb)))

(define (sailors)
 (define father first)
 (define daughter second)
 (define yachet third)
 (define (different-names father)
  (not (eq? (daughter father) (yachet father))))
 (let ((moore (list 'moore 'mary 'lorna))
	   (downing (list 'downing (amb 'gabrielle 'lorna 'rosalind) 'melissa))
	   (hall (list 'hall (amb 'gabrielle 'lorna) 'rosalind))
	   (barnacle (list 'barnacle 'melissa 'gabrielle))
	   (parker (list 'parker (amb 'gabrielle 'lorna 'rosalind) 'mary)))
  (let ((gabrielle-father (amb downing hall parker))
		(lorna-father (amb downing hall parker))
		(rosalind (amb downing parker)))
   (require (eq? (daughter gabrielle-father) 'gabrielle))
   (require (eq? (daughter lorna-father) 'lorna))
;;;   (require (eq? (daughter rosalind-father) 'rosalind))  rosalind-father is doommed not equal to gabrielle-father and lorna-father,therefore, this line is not necessary
   (require (eq? (daughter parker) (yachet gabrielle-father)))
   (father lorna-father))))


