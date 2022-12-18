(define (over-or-under num1 num2)
  'YOUR-CODE-HERE
  (if (< num1 num2) -1 (if (= num1 num2) 0 1))
)

;;; Tests
(over-or-under 1 2)
; expect -1
(over-or-under 2 1)
; expect 1
(over-or-under 1 1)
; expect 0


(define (filter-lst fn lst)
  'YOUR-CODE-HERE
  (if (null? lst) lst 
    (if (fn (car lst)) 
      (cons (car lst) (filter-lst fn (cdr lst))) 
      (filter-lst fn (cdr lst))))
)

;;; Tests
(define (even? x)
  (= (modulo x 2) 0))
(filter-lst even? '(0 1 1 2 3 5 8))
; expect (0 2 8)


(define (make-adder num)
  'YOUR-CODE-HERE
  (lambda (x) (+ x num))
)

;;; Tests
(define adder (make-adder 5))
(adder 8)
; expect 13


(define lst
  (list (list 1) 2 (list 3 4) 5)
)


(define (composed f g)
  (lambda (x) (f (g x)))
)


(define (remove item lst)
  (filter-lst (lambda (x) (not (= x item))) lst)
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)


(define (no-repeats s)
  (if (null? s) 
    s 
    (cons (car s) (no-repeats (remove (car s) (cdr s))))
  )
)


(define (substitute s old new)
  (if (null? s) 
    s
    (if (eq? (car s) old) 
      (cons new (substitute (cdr s) old new)) 
      (if (pair? (car s)) 
        (cons (substitute (car s) old new) (substitute (cdr s) old new)) 
        (cons (car s) (substitute (cdr s) old new))
      )
       
    )
  )

)


(define (sub-all s olds news)
  (if (null? olds) 
    s 
    (sub-all (substitute s (car olds) (car news)) (cdr olds) (cdr news))
  )
)

; disc 10
(define (my-append a b)
  (if (null? a) 
    b
    (cons (car a) (my-append (cdr a) b))
  )
  
)

;;; Tests
(my-append '(1 2 3) '(2 3 4))
; expect (1 2 3 2 3 4)

(define (insert element lst index)
  (if (eq? 0 index)
    (cons element lst)
    (cons (car lst) (insert element (cdr lst) (- index 1)))
  )
)
;;; Tests
(insert 1 '(2 3 4) 0)
; expect (1 2 3 4)
(insert 1 '(2 3 4) 1)
; expect (2 1 3 4)

(define (duplicate lst)
  (if (null? lst) 
    lst
    (list (car lst) (car lst) (duplicate (cdr lst)))
  )
)
;;; Tests
(duplicate '(2 3 4))
; expect (2 2 3 3 4 4)