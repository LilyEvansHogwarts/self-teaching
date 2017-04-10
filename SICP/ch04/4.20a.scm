(define (letrec? exp) (tagged-list? exp 'letrec))

(define (letrec-inits exp) (cadr exp))

(define (letrec-body exp) (cddr exp))

(define (declare-variables exp)
 (map (lambda (x) (list (car x) '*unassigned*)) (letrec-inits exp)))

(define (set-variables exp)
 (map (lambda (x) (list 'set! (car x) (cadr x))) (letrec-inits exp)))

(define (make-let inits body)
 (list 'let inits body))

(define (letrec->let exp)
 (make-let (declare-variables exp) (make-begin (append (set-variables exp) (letrec-body exp)))))
