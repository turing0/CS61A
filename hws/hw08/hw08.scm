(define (next s cur)
    (if (null? s) nil
        (if (= (car s) cur) (next (cdr-stream s) cur)
            s
        )
    )
)
(define (rle s)
    (define (hepler cur num s)
        (if (null? s) (list cur num)
            (if (= (car s) cur) (hepler cur (+ num 1) (cdr-stream s))
                (list cur num)
            )
        )
    )
    (if (null? s) nil
        (cons-stream (hepler (car s) 0 s) (rle (next s (car s))))
    )
    
)

(define (next2 s cur)
    (if (null? s) nil
        (if (< (car s) cur) s
            (next2 (cdr-stream s) (car s))
        )
    )
)
(define (group-by-nondecreasing s)
    (define (hepler pre cur s)
        (if (null? s) pre
            (if (<= cur (car s)) (hepler (append pre (list (car s))) (car s) (cdr-stream s))
                pre
            )
        )
    )
    (if (null? s) nil
        (cons-stream (hepler (list (car s)) (car s) (cdr-stream s)) (group-by-nondecreasing (next2 s (car s))))
    )
)


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

