(define (make-queue)
 (cons '() '()))

(define (front-queue queue) (car queue))
(define (rear-queue queue) (cdr queue))

(define (empty-queue? q) (null? (front-queue q)))

(define (set-front-queue! q value)
 (set-car! q value))
(define (set-rear-queue! q value)
 (set-cdr! q value))

(define (last-pair q)
 (let ((lst (front-queue q)))
  (define (iter lst)
   (if (null? (cddr lst))
	lst
	(iter (cdr lst))))
  (iter lst)))

(define (one-element q)
 (if (null? (cdr (front-queue q)))
  true
  false))

(define (insert-queue! q value)
 (if (empty-queue? q)
  (let ((lst (list value)))
   (set-front-queue! q lst)
   (set-rear-queue! q lst))
  (set-front-queue! q (cons value (front-queue q))))
 q)

(define (delete-queue! q)
 (cond ((empty-queue? q)
		(error "the queue is empty -- delete" q))
       ((one-element q) (set! q (make-queue))
						q)
	   (else (set-rear-queue! q (last-pair q))
			 (set-cdr! (rear-queue q) '())
			 q)))


