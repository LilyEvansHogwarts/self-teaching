(define (let? exp)
 (tagged-list? exp 'let))

(define (let-declare exp) (cadr exp))

(define (let-body exp) (cddr exp))

(define (let-variables exp) (map car (let-declare exp)))

(define (let-values exp) (map cadr (let-declare exp)))

;;;由于在operands函数中，对应的为cdr，且相应(let-values exp)已经为一个list，因此，相应的结果应该用cons构造

(define (let->combination exp)
 (cons (make-lambda (let-variables exp) (let-body exp))
	   (let-values exp)))

;;;((let? exp) (analyze (let->combination exp)))

