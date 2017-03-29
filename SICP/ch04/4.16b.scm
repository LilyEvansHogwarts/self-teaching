(define (scan-out-defines body)
 (define (name-unassigned defines)
  (map (lambda (x) (list (definition-variable x) '*unassigned*)) defines))
 (define (set-values defines)
  (map (lambda (x) (list 'set! (definition-variable x) (definition-value x))) defines))
 (define (defines->let exprs defines not-defines)
  (cond ((null? exprs)
		 (if (null? defines)
		  body
		  (list (list 'let (name-unassigned defines) (make-begin (append (set-values-defines) (reverse not-defines)))))))
   (definition?

