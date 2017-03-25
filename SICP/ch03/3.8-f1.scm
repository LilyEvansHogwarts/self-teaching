(define f
  (lambda (first-args)
    (set! f (lambda (second-args) 0))
    first-args))
