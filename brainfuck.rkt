#lang racket/base
(require racket/file)
(define (nth lst ind)
    (if (= ind 0)
        (car lst)
        (nth (cdr lst)(- ind 1))))

(define (replace-item lst ind val)
    (if (= ind 0)
        (cons val (cdr lst))
        (cons (car lst)(replace-item (cdr lst) (- ind 1) val))))

(define (retrieve-left code index amount)
    (if (= amount 0)
        (+ index 1)
        (let ((c (substring code (- index 1) index)))
            (printf c)
            (if (string=? c "[")
                (retrieve-left code (- index 1)(- amount 1))
                (if (string=? c "]")
                    (retrieve-left code (- index 1)(+ amount 1))
                    (retrieve-left code (- index 1) amount))))))

(define (retrieve-right code index amount)
    (if (= amount 0)
        index
        (let ((c (substring code index (+ index 1))))
            (if (string=? c "]")
                (retrieve-right code (+ index 1)(- amount 1))
                (if (string=? c "[")
                    (retrieve-right code (+ index 1)(+ amount 1))
                    (retrieve-right code (+ index 1) amount))))))

(define (run-bf code iptr data dptr len)
    (if (not (= iptr len))
        (let ((c (string-ref code iptr)))
            (case c
                [(#\>) (run-bf code (+ iptr 1) data (+ dptr 1) len)]
                [(#\<) (run-bf code (+ iptr 1) data (- dptr 1) len)]
                [(#\+) (run-bf code (+ iptr 1) (replace-item data dptr (+ (nth data dptr) 1)) dptr len)]
                [(#\-) (run-bf code (+ iptr 1) (replace-item data dptr (- (nth data dptr) 1)) dptr len)]
                [(#\.) (printf "~a" (integer->char (nth data dptr)))(run-bf code (+ iptr 1) data dptr len)]
                [(#\,) (run-bf code (+ iptr 1) (replace-item data dptr (char->integer (read-char (current-input-port)))) dptr len)]
                [(#\[) (if (= (nth data dptr) 0)(run-bf code (retrieve-right code iptr 1) data dptr len)(run-bf code (+ iptr 1) data dptr len))]
                [(#\]) (if (not (= (nth data dptr) 0))(run-bf code (retrieve-left code (- iptr 1) 1) data dptr len)(run-bf code (+ iptr 1) data dptr len))]
                [else (run-bf code (+ iptr 1) data dptr len)]))
    '()))

(define code (file->string (vector-ref (current-command-line-arguments) 0)))
(define res (run-bf code 0 (build-list 30000 (lambda (x) 0)) 0 (string-length code)))
