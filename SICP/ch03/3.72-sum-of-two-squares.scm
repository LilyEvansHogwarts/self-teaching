(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
	((stream-null? s2) s1)
	(else (let ((cars1 (stream-car s1))
		    (cars2 (stream-car s2)))
		(cond ((< (weight cars1) (weight cars2))
		       (cons-stream cars1 (merge-weighted (stream-cdr s1) s2 weight)))
		      ((= (weight cars1) (weight cars2))
		       (cons-stream cars1 (merge-weighted (stream-cdr s1) s2 weight)))
		      (else 
			(cons-stream cars2 (merge-weighted s1 (stream-cdr s2) weight))))))))

(define (weighted-pairs s1 s2 weight)
  (cons-stream (list (stream-car s1) (stream-car s2))
	       (merge-weighted (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2))
			       (weighted-pairs (stream-cdr s1) (stream-cdr s2) weight)
			       weight)))

(define weight1 (lambda (x) (+ (square (car x)) (square (cadr x)))))

(define (determine stream weight)
  (let ((s1 (stream-car stream))
	(s2 (stream-car (stream-cdr stream)))
	(s3 (stream-car (stream-cdr (stream-cdr stream)))))
    (if (and (= (weight s1) (weight s2)) (= (weight s2) (weight s3)))
      (cons-stream (list (weight s1) s1 s2 s3) 
		   (determine (stream-cdr (stream-cdr (stream-cdr stream))) weight))
      (determine (stream-cdr stream) weight))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define q (determine (weighted-pairs integers integers weight1) weight1))

(define (show x)
  (newline)
  (display x)
  x)

(define (s n)
  (stream-ref (stream-map show q) n))
