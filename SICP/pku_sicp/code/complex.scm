(define (tag obj) (car obj))
(define (content obj) (cdr obj))

(define (make-complex-from-rect real imag)
 (list 'rect real imag))
(define (make-complex-from-polar mag ang)
 (list 'polar mag ang))
(define (make-complex tag a b)
 (if (or (eq? tag 'rect) (eq? tag 'polar))
  (list tag a b)
  (error "unknown form of tag -- make-complex" tag)))

(define (real z)
 (cond ((eq? (tag z) 'rect) (car (content z)))
	   ((eq? (tag z) 'polar) (* (car (content z))
							    (cos (cadr (content z)))))
	   (else (error "unknown form of object -- real" z))))

(define (imag z)
 (cond ((eq? (tag z) 'rect) (cadr (content z)))
	   ((eq? (tag z) 'polar) (* (car (content z))
								(sin (cadr (content z)))))
	   (else (error "unknown form of object -- imag" z))))

(define (mag z)
 (cond ((eq? (tag z) 'rect) (sqrt (+ (square (car (content z)))
								     (square (cadr (content z))))))
	   ((eq? (tag z) 'polar) (car (content z)))
	   (else (error "unknown form of object -- magnitude" z))))

(define (ang z)
 (cond ((eq? (tag z) 'rect) (atan (/ (cadr (content z)) (car (content z)))))
	   ((eq? (tag z) 'polar) (cadr (content z)))
	   (else (error "unknown form of object -- angle" z))))


