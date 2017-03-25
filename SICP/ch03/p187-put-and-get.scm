(load "p187-table-two-dimension.scm")

(define operation-table (make-table))

(define get (operation-table 'lookup-proc))

(define put (operation-table 'insert-proc))
