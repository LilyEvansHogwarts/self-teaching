(define (make-deque)
  (cons '() '()))

(define (front-ptr deque)
  (car deque))

(define (rear-ptr deque)
  (cdr deque))

(define (set-front-ptr! deque item) 
  (set-car! deque item))

(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (empty-deque? deque)
  (null? (front-ptr deque)))

(define (print-deque deque)
  (display (front-ptr deque))
  (newline))

(define (front-insert-deque! deque item)
  (let ((new-pair (cons item '())))
    (cond ((empty-deque? deque)
	   (set-front-ptr! deque new-pair)
	   (set-rear-ptr! deque new-pair)
	   (print-deque deque))
	  (else 
	   (set-front-ptr! deque (cons item (front-ptr deque)))
	   (print-deque deque)))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons item '())))
    (cond ((empty-deque? deque)
	   (set-front-ptr! deque new-pair)
	   (set-rear-ptr! deque new-pair)
	   (print-deque deque))
	  (else 
	    (set-cdr! (rear-ptr deque) new-pair)
	    (set-rear-ptr! deque new-pair)
	    (print-deque deque)))))

(define (front-delete-deque! deque)
  (if (empty-deque? deque)
    (error "Delete! Called with an empty deque" deque)
    (begin (set-front-ptr! deque (cdr (front-ptr deque)))
	   (print-deque deque))))

(define (rear-delete-deque! deque)
  (define (iter lst)
    (cond ((null? (cdr (cdr lst)))
	   (set-cdr! lst '())
	   (set-rear-ptr! deque lst)
	   (print-deque deque))
	  (else 
	    (iter (cdr lst)))))
  (cond ((empty-deque? deque)
	 (error "empty deque" deque))
	((null? (cdr (front-ptr deque)))
	 (set-front-deque! deque '())
	 (set-rear-deque! deque '())
	 (print-deque deque))
	(else (iter (front-ptr deque)))))
