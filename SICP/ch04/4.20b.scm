(define (f1 x)
 (let ((new-even? (lambda (n)
				   (if (= n 0)
					true
					(new-odd? (- n 1)))))
	   (new-odd? (lambda (n)
				  (if (= n 0)
				   false
				   (new-even? (- n 1))))))
  (new-even? x)))

(define (f2 x)
 ((lambda (new-even? new-odd?)
   (new-even? x))
  (lambda (n) 
   (if (= n 0)
	true
	(new-odd? (- n 1))))
  (lambda (n)
   (if (= n 0)
	false
	(new-even? (- n 1))))))

(define (f3 x)
 (define (new-even? n)
  (if (= n 0)
   true
   (new-odd? (- n 1))))
 (define (new-odd? n)
  (if (= n 0)
   false
   (new-even? (- n 1))))
 (new-even? x))

(define (f4 x)
 (letrec ((new-even? (lambda (n)
				   (if (= n 0)
					true
					(new-odd? (- n 1)))))
	   (new-odd? (lambda (n)
				  (if (= n 0)
				   false
				   (new-even? (- n 1))))))
  (new-even? x)))
