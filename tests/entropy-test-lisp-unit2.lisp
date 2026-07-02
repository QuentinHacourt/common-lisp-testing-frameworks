(defpackage :entropy-test-lisp-unit2
  (:use :cl :entropy))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (ql:quickload :lisp-unit2))

(in-package :entropy-test-lisp-unit2)

(lisp-unit2:define-test str-len-test
    (:tags :entropy)
  (lisp-unit2:assert-equal 0 (str-len ""))
  (lisp-unit2:assert-equal 3 (str-len "abc"))
  (lisp-unit2:assert-equal 5 (str-len "asdfg")))

(lisp-unit2:define-test unique-symbols-test
    (:tags :entropy)
  (lisp-unit2:assert-equal (list #\a #\b #\c) (unique-symbols "abc"))
  (lisp-unit2:assert-equal (list #\a) (unique-symbols "aaaaaaaa"))
  (lisp-unit2:assert-equal '() (unique-symbols "")))

(lisp-unit2:define-test count-appearances-test
    (:tags :entropy)
  (let ((str ""))
    (lisp-unit2:assert-equal '() (count-appearances (unique-symbols str) str)))
  (let ((str "aaa"))
    (lisp-unit2:assert-equal (list (list #\a 3)) (count-appearances (unique-symbols str) str)))
  (let ((str "abc"))
    (lisp-unit2:assert-equal (list (list #\a 1) (list #\b 1) (list #\c 1))
                             (count-appearances (unique-symbols str) str)))
  (let ((str "abbcccad"))
    (lisp-unit2:assert-equal (list (list #\a 2) (list #\b 2) (list #\c 3) (list #\d 1))
                             (count-appearances (unique-symbols str) str))))

(lisp-unit2:define-test compute-probabilities-test
    (:tags :entropy)
  (let ((str ""))
    (lisp-unit2:assert-equal '() (compute-probabilities (count-appearances (unique-symbols str) str)
                                                        (str-len str))))
  (let* ((str "aaa")
         (result (compute-probabilities (count-appearances (unique-symbols str) str) (str-len str))))
    (lisp-unit2:assert-equal (list #\a) (mapcar #'first result))
    (lisp-unit2:assert-true (every #'approx-equal (list 1.0) (mapcar #'second result))))
  (let* ((str "abc")
         (result (compute-probabilities (count-appearances (unique-symbols str) str) (str-len str))))
    (lisp-unit2:assert-equal (list #\a #\b #\c) (mapcar #'first result))
    (lisp-unit2:assert-true (every #'approx-equal (list 0.333 0.333 0.333) (mapcar #'second result))))
  (let* ((str "abbcccad")
         (result (compute-probabilities (count-appearances (unique-symbols str) str) (str-len str))))
    (lisp-unit2:assert-equal (list #\a #\b #\c #\d) (mapcar #'first result))
    (lisp-unit2:assert-true (every #'approx-equal (list 0.25 0.25 0.375 0.125) (mapcar #'second result)))))

(lisp-unit2:define-test compute-entropy-test
    (:tags :entropy)
  (lisp-unit2:assert-true (approx-equal 0 (compute-entropy "aaa")))
  (lisp-unit2:assert-true (approx-equal 1.58 (compute-entropy "abc")))
  (lisp-unit2:assert-true (approx-equal 4.02 (compute-entropy "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")))
  (lisp-unit2:assert-true (approx-equal 1.00 (compute-entropy "01001011010000001010101110111001000011011100000100011101001100110101011100000000101100011011000001011001011010100111010000010110110111010110100010111011111000101101"))))

;; Helper functions
(defun approx-equal (a b)
  (< (abs (- a b)) 0.01))
