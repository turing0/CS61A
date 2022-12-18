(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)


(define (sign num)
  (cond 
    ((> num 0) 1)
    ((< num 0) -1)
    (else 0)
    )
)


(define (square x) (* x x))

(define (pow x y)
  (cond
    ((= y 0) 1)
    ((even? y) (square (pow x (/ y 2))))
    (else (* x (square (pow x (/ (- y 1) 2)))))
  )
)


(define (unique s)
  (if (null? s) 
    s
    (cons (car s) (unique (filter (lambda (x) (not (eq? x (car s))) ) (cdr s))))

  )
)


(define (replicate x n)
  (define (it x n lst)
    (if (eq? n 0)
      lst
      (it x (- n 1) (cons x lst))
    )
  )
  (it x n nil)
)


(define (accumulate combiner start n term)
  (if (eq? n 0)
    start
    (combiner (term n) (accumulate combiner start (- n 1) term))
  )
)


(define (accumulate-tail combiner start n term)
  (define (it combiner start n term res)
    (if (eq? n 0)
      res
      (it combiner start (- n 1) term (combiner (term n) res))
    )
  )
  (it combiner start n term start)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst))
  
)

;disc11

(define (reverse lst)
  (define (it lst reversed)
    (if (null? lst)
      reversed
      (it (cdr lst) (cons (car lst) reversed))
    )
  )
  (it lst nil)
)
;;; Tests
(reverse nil)
; expect ()
(reverse '(1 3 5))
; expect (5 3 1)

(define (insert n lst)
  (cond 
    ((null? lst) (cons n nil))
    ((not (> n (car lst))) (cons n lst))
    (else (cons (car lst) (insert n (cdr lst))))
  )
)
;;; Tests
(insert 6 '(2 4 5 7))
; expect (2 4 5 6 7)
(insert 5 '(2 4 5 7))
; expect (2 4 5 5 7)
(insert 0 '(2 4 5 7))
; expect (0 2 4 5 7)
(insert 7 '(2 4 5 7))
; expect (2 4 5 7 7)
(insert 9 '(2 4 5 7))
; expect (2 4 5 7 9)
(insert 9 nil)
; expect (9)


; (define-macro (or-macro expr1 expr2)
; `(let ((v1 ,expr1))
;   (if v1 v1 
;     ,expr2)))
; (define (hepler args res flag fn)
;     (cond 
;       ((null? args) res)
;       ((eq? flag 1) (hepler (cdr args) (eval (list fn res (car args))) 0 fn))
;       ((eq? flag 0) (hepler (cdr args) res 1 fn))
;     )
;   )
; (define-macro (prune-expr expr)
;   `(hepler (cdr (cdr ',expr)) (car (cdr ',expr)) 0 (car ',expr))
; )

(define (hepler args remained flag fn)
    (cond 
      ((null? args) (eval (cons fn remained)))
      ((eq? flag 1) (hepler (cdr args) (cons (car args) remained) 0 fn))
      ((eq? flag 0) (hepler (cdr args) remained 1 fn))

    )
  )
(define-macro (prune-expr expr)
  `(hepler (cdr ',expr) nil 1 (car ',expr))
)

(prune-expr (+ 10))
(prune-expr (+ 10 100))
(prune-expr (+ 10 100 1000))
(prune-expr (prune-expr (+ 10 100) 'garbage))

; (define-macro (when condition exprs)
; (list 'if_______________))

(define-macro (when condition exprs)
`(if ,condition (eval (cons 'begin ',exprs)) 'okay))

(when (= 1 1) ((print 6) (print 1) 'a))
(when (= 1 0) ((/ 1 0) 'error))