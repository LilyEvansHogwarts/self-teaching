(load "p112-encode.scm")
(load "p112-decode.scm")
(load "2.69-generate-huffman-tree.scm")
(define (test)
  (define x '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1)))
  (define tree (generate-huffman-tree x))
  (define a1 '(Get a job))
  (define a2 '(SHA na na na na na na na na))
  (define a3 '(Wah yip yip yip yip yip yip yip yip))
  (define a4 '(sha boom))
  (define x1 (encode a1 tree))
  (define x2 (encode a2 tree))
  (define x3 (encode a3 tree))
  (define x4 (encode a4 tree))
  (define y1 (decode x1 tree))
  (define y2 (decode x2 tree))
  (define y3 (decode x3 tree))
  (define y4 (decode x4 tree))
  (display x1)
  (newline)
  (display y1)
  (newline)
  (display x2)
  (newline)
  (display y2)
  (newline)
  (display x1)
  (newline)
  (display y1)
  (newline)
  (display x2)
  (newline)
  (display y2)
  (newline)
  (display x3)
  (newline)
  (display y3)
  (newline)
  (display x4)
  (newline)
  (display y4)
  (newline))
