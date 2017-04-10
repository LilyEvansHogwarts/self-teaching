;;;在mit-scheme中进行实验的时候，发现最终报错，也就是说Alyssa的观点是对的，
;;;实际上，SICP的作者也说这种方法才是MIT scheme使用的

(define (haha)
 (let ((a 1))
  (define (f x)
   (define b (+ a x))
   (define a 5)
   (+ a b))
  (f 10)))

;;;在对于(define b (+ a x))求值的时候，会直接提取definition-value为(+ a x)，并对于(+ a x)进行求值，然后会发现a依旧处于'*unassigned*的状态

