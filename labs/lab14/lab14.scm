(define (split-at lst n)
	(define (helper head n tail)
		(if (null? tail) (cons head nil)
			(if (= n 0) (cons head tail)
				(helper (append head (list (car tail))) (- n 1) (cdr tail))
			)
		)
	)
	(helper nil n lst)
)


(define-macro (switch expr cases)
	(let ((val (eval expr)))
		(cons 'cond
			(map (lambda (case) 
				(cons (eq? val (car case)) (cdr case)))
	    			cases
			)
		)
	)
)

