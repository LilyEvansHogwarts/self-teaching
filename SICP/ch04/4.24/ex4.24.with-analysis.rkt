#lang racket/base
; Translation procedures:
(require racket/mpair)

(define (exp->mlist exp)
  (if (pair? exp)
      (foldr (lambda (x rest)
               (if (pair? x)
                   (mcons (exp->mlist x) rest)
                   (mcons x rest)))
             null exp)
      exp))
(define (mlist->exp exp)
  (if (mlist? exp)
      (mlist->list exp)
      exp))

(define (run-interpreter exp)
  (mlist->exp (interpret (exp->mlist exp))))

(require "ex4.22.rkt")
(collect-garbage)
(time
 (begin
   (run-interpreter '(define (factorial n)
                       (if (< n 2)
                           1
                           (* (factorial (- n 1)) n))))
   (run-interpreter '(define (fib n)
                       (cond ((= n 0) 0)
                             ((= n 1) 1)
                             (else (+ (fib (- n 1)) (fib (- n 2)))))))
   (do ((i 1 (+ i 1)))
     ((> i 500) 'complete)
     (run-interpreter '(factorial 50)))
   (do ((j 1 (+ j 1)))
     ((> j 20) 'complete)
     (run-interpreter '(fib 20)))))



