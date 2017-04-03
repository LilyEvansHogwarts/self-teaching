(define (pascal j n)
 (/ (help n 1 (+ n (- j) 1))
  (help j 1 1)))

(define (help end result start)
 (if (= end start)
  (* result end)
  (help (- end 1) (* result end) start)))
