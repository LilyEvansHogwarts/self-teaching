(define (make-graph-entry node children contents)
 (list 'graph-entry node children contents))

(define (graph-entry? entry)
 (and (pair? entry) (eq? 'graph-entry (car entry))))

(define (graph-entry->node entry)
 (if (not (graph-entry? entry))
  (error "Object not entry: " entry)
  (first (cdr entry))))

(define (graph-entry->children entry)
 (if (not (graph-entry? entry))
  (error "Object not entry: " entry)
  (second (cdr entry))))

(define (graph-entry->contents entry)
 (if (not (graph-entry? entry))
  (error "Object not entry: " entry)
  (third (cdr entry))))

(define (make-graph entries)
 (cons 'graph entries))

(define (graph? graph)
 (and (pair? graph) (eq? 'graph (car graph))))

(define (graph-entries graph)
 (if (not (graph? graph))
  (error "Object not a graph: " graph)
  (cdr graph)))

(define (graph-root graph)
 (let ((entries (graph-entries graph)))
  (if (null? entries)
   false
   (graph-entry->node (car entries)))))

(define (search next-place start-node)
 (define (loop node)
  (let ((next-node (next-place node)))
   (cond ((eq? next-node #t) 'FOUND)
		 ((eq? next-node #f) 'NOT-FOUND)
		 (else (loop next-node)))))
 (loop start-node))

(define (depth-first-strategy graph goal? children)
 (let ((*to-be-visited* '()))
  (define (where-next? here)
   (set! *to-be-visited* (append (children graph here) *to-be-visited*))
   (cond ((goal? here) #t)
		 ((null? *to-be-visited*) #f)
		 (else (let ((next (car *to-be-visited*)))
				(set! *to-be-visited (cdr *to-be-visited*))
				next))))
  where-next?))

(define (breadth-first-strategy graph goal? children)
 (let ((*to-be-visited* '()))
  (define (where-next? here)
   (set! *to-be-visited* (append *to-be-visited* (children graph here)))
   (cond ((goal? here) #t)
		 ((null? *to-be-visited*) #f)
		 (else (let ((next (car *to-be-visited*)))
				(set! *to-be-visited* (cdr *to-be-visited*))
				next))))
  where-next?))
