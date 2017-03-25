(load "3.60-mul-series.scm")
(load "3.59-serial.scm")

(define cosine-2 (mul-series cosine-series cosine-series))
(define sine-2 (mul-series sine-series sine-series))

(define a (add-streams cosine-2 sine-2))
