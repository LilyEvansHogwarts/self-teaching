(define (unless predicate consequent alternative)
 (if predicate alternative consequent))

;;;(define (factorial n)
;;; (unless (= n 1)
;;;  (* n (factorial (- n 1)))
;;;  1))

;;;(factorial 5)

;;;Aborting!: maximum recursive depth exceeded

;;;(define (factorial n)
;;; (if (= n 1)
;;;  1
;;;  (* n (factorial (- n 1)))))

;;;(factorial 5)

;;;之所以如果直接采用if,不会出现栈溢出的情况是因为,在scheme系统内会先判断predicate语句之后，才去执行相应的语句，而对于unless而言，由于要带入到if中，会先要讲predicate、consequent、alternative三个值都求出来才会继续运行，然而(* n (factorial (- n 1)))求值过程会在堆栈中产生很长的procedure,造成栈溢出
;;;由于(factorial (- n 1))一直处于一个求值的状态，而且在对(* n (factorial (- n 1))),不会判断(= n 0)的问题，因此会造成n的值没有下界
