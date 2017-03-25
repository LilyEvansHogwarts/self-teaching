(define counter 0)

(define f
  (lambda (x)
    (set! counter (+ counter 1))
    (if (odd? counter)
      x
      0)))

