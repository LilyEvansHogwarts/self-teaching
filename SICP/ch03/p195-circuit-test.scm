(load "p190-half-adder.scm")
(load "p191-and-gate.scm")
(load "p192-make-wire.scm")
(load "p194-make-agenda.scm")

(define the-agenda (make-agenda))

(define inverter-delay 2)

(define and-gate-delay 3)

(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))


(set-signal! input-1 1)

(half-adder  input-1 input-2 sum carry)
(probe 'sum sum)
(probe 'carry carry)
(propagate)
(set-signal! input-2 1)
(propagate)

