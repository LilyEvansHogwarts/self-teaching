(define (make-stack)
 (list 'stack))


(define (stack? stack)
 (and (pair? stack) (eq? 'stack (car stack))))

(define (empty-stack? stack)
 (if (not (stack? stack))
  (error "object is not a stack -- empty-stack?" stack)
  (null?  stack)))

(define (push stack elt)
 (cond ((not (stack? stack))
		(error "object is not a stack -- push" stack))
	   (else (set-cdr! stack (cons elt (cdr stack)))
			 stack)))

(define (pop stack)
 (cond ((not (stack? stack))
		(error "object is not a stack -- pop" stack))
	   ((empty-stack? stack)
		(error "the stack is empty -- pop" stack))
	   (else (set-cdr! stack (cddr stack))
			 stack)))

(define (top stack)
 (cond ((not (stack? stack))
		(error "object is not a stack -- top" stack))
	   ((empty-stack? stack)
		(error "the stack is empty -- top" stack))
	   (else (cadr stack))))



