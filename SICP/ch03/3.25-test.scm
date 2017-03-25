(load "3.25-table.scm")

(define (test)
  (define t (make-table))
  (insert! (list 'math '+) 45 t)
  (insert! (list 'haha 'lili 'lala 'james 'potter 'snape) 5 t)
  (lookup (list 'haha 'lili 'lala) t)
  (display t))
