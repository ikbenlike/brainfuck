(require 'asdf)
(defpackage #:brainfuck
    (:use #:cl #:uiop))

(in-package #:brainfuck)

(defun file-string (path)
    (with-open-file (stream path)
        (let ((data (make-string (file-length stream))))
            (read-sequence data stream)
            data)))

(defun index-lst (lst ind)
    (if (= ind 0)
        (car lst)
        (index-lst (cdr lst)(- ind 1))))

(defun replace-item (lst ind val)
    (if (= ind 0)
        (cons val (cdr lst))
        (cons (car lst)(replace-item lst (- ind 1) val))))

(defun retrieve-left (code index amount)
    (if (= amount 0)
        (+ index 1)
        (let ((c (char code index)))
            (if (char= c #\[)
                (retrieve-left code (- index 1)(- amount 1))
                (if (char= c #\])
                    (retrieve-left code (- index 1)(+ amount 1))
                    (retrieve-left code (- index 1) amount))))))

(defun retrieve-right (code index amount)
    (if (= amount 0)
        index
        (let ((c (char code index)))
            (if (char= c #\])
                (retrieve-right code (+ index 1)(- amount 1))
                (if (char= c #\[)
                    (retrieve-right code (+ index 1)(+ amount 1))
                    (retrieve-right code (+ index 1) amount))))))

(defun run-bf (code iptr data dptr len)
    (if (not (= iptr len))
        (let ((c (char code iptr)))
            (cond
                ((char= c #\>)(run-bf code (+ iptr 1) data (+ dptr 1) len))
                ((char= c #\<)(run-bf code (+ iptr 1) data (- dptr 1) len))
                ((char= c #\+)(run-bf code (+ iptr 1) (replace-item data dptr (+ (index-lst data dptr) 1)) dptr len))
                ((char= c #\-)(run-bf code (+ iptr 1) (replace-item data dptr (- (index-lst data dptr) 1)) dptr len))
                ((char= c #\.)(format *STANDARD-OUTPUT* "~a" (code-char (index-lst data dptr)))(run-bf code (+ iptr 1) data dptr len))
                ((char= c #\,)(run-bf code (+ iptr 1) (replace-item data dptr (char-code (read-char))) dptr len))
                ((char= c #\[)(if (= (index-lst data dptr) 0)(run-bf code (retrieve-right code iptr 1) data dptr len)(run-bf code (+ iptr 1) data dptr len)))
                ((char= c #\])(if (not (= (index-lst data dptr) 0))(run-bf code (retrieve-left code (- iptr 1) 1) data dptr len)(run-bf code (+ iptr 1) data dptr len)))))))

(let ((code (file-string (index-lst uiop:*command-line-arguments* 0))))
    (run-bf code 0 (make-list 30000 :initial-element 0) 0 (length code)))
