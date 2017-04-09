(define (make-queue)
 (cons 'queue (cons '() '())))

(define (tag q) (car q))

(define (front-queue q) (cadr q))
(define (rear-queue q) (cddr q))

(define (queue? q)
 (and (pair? q) (eq? (tag q) 'queue)))

(define (empty-queue? q)
 (if (not (queue? q))
  (error "the object is not a queue -- empty-queue?" q)
  (null? (front-queue q))))

(define (set-front-queue! q item)
 (set-car! (cdr q) item))

(define (set-rear-queue! q item)
 (set-cdr! (cdr q) item))

(define (insert-queue! q elt)
 (let ((new-pair (list elt)))
  (cond ((empty-queue? q)
		 (set-front-queue! q new-pair)
		 (set-rear-queue! q new-pair)
		 q)
		(else 
		 (set-cdr! (rear-queue q) new-pair)
		 (set-rear-queue! q new-pair)
		 q))))

(define (delete-queue! q)
 (cond ((empty-queue? q)
		(error "the queue is empty -- delete-queue!" q))
	   (else (set-front-queue! q (cdr (front-queue q)))
		     q)))
