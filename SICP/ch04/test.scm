(load "p297-analyze.scm")

(define a '(begin
(define nouns '(noun student professor cat class))
(define verbs '(verb studies lectures eats sleeps))
(define articles '(article the a))
(define (require p)
 (if (not p) (amb)))
(define (parse-sentence)
 (list 'sentence
  (parse-noun-phrase)
  (parse-word verbs)))
(define (parse-noun-phrase)
 (list 'noun-phrase
  (parse-word articles)
  (parse-word nouns)))
(define (parse-word word-list)
 (require (not (null? *unparsed*)))
 (require (memq (car *unparsed*) (cdr word-list)))
 (define found-word (car *unparsed*))
 (set! *unparsed* (cdr *unparsed*))
 (list (car word-list) found-word))
(define *unparsed* '())
(define (parse input)
 (set! *unparsed* input)
 (define sent (parse-sentence))
 (require (null? *unparsed*))
 sent)
(parse '(the cat eats))))

(define (prime? n)
 (define (iter i)
  (cond ((> (* i i) n) true)
	    ((= 0 (remainder n i)) false)
		(iter (+ i 1))))
 (iter 2))

(define (
