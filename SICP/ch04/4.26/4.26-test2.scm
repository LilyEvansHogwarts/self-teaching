(load "eval-let-unless.scm")

(define a '(begin
			(define select-y (list true false true true))
			(define xs (list 1 3 5 7))
			(define ys (list 2 4 6 8))
			(define selected (map unless select-y xs ys))
			 selected))

(display (interpret a))

;;;发现运行过程会报错，说明unless作为一个特殊形式的时候不能用于高阶函数
