(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else (append set1 set2))))
