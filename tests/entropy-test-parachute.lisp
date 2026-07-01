(defpackage :entropy-test-parachute
  (:use :cl :parachute :entropy))

(in-package :entropy-test-parachute)


(define-test str-len-test
  (is = 0 (str-len ""))
  (is = 3 (str-len "abc"))
  (is = 5 (str-len "asdfg")))

(define-test unique-symbols-test
  (is equal (list #\a #\b #\c) (unique-symbols "abc"))
  (is equal (list #\a) (unique-symbols "aaaaaaaa"))
  (is equal '() (unique-symbols "")))

(define-test count-appearances-test
  (let ((str ""))
    (is equal '() (count-appearances (unique-symbols str) str)))
  (let ((str "aaa"))
    (is equal (list (list #\a 3)) (count-appearances (unique-symbols str) str)))
  (let ((str "abc"))
    (is equal (list (list #\a 1) (list #\b 1) (list #\c 1))
        (count-appearances (unique-symbols str) str)))
  (let ((str "abbcccad"))
    (is equal (list (list #\a 2) (list #\b 2) (list #\c 3) (list #\d 1))
        (count-appearances (unique-symbols str) str))))

(define-test compute-probabilities-test
  (let ((str ""))
    (is equal '() (compute-probabilities (count-appearances (unique-symbols str) str)
                                         (str-len str))))
  (let* ((str "aaa")
         (result (compute-probabilities (count-appearances (unique-symbols str) str) (str-len str))))
    (is equal (list #\a) (mapcar #'first result))
    (true (every #'approx-equal (list 1.0) (mapcar #'second result))))
  (let* ((str "abc")
         (result (compute-probabilities (count-appearances (unique-symbols str) str) (str-len str))))
    (is equal (list #\a #\b #\c) (mapcar #'first result))
    (true (every #'approx-equal (list 0.333 0.333 0.333) (mapcar #'second result))))
  (let* ((str "abbcccad")
         (result (compute-probabilities (count-appearances (unique-symbols str) str) (str-len str))))
    (is equal (list #\a #\b #\c #\d) (mapcar #'first result))
    (true (every #'approx-equal (list 0.25 0.25 0.375 0.125) (mapcar #'second result)))))

(define-test compute-entropy-test
  (is = 0 (compute-entropy "aaa"))
  (true (approx-equal 1.58 (compute-entropy "abc")))
  (true (approx-equal 4.02 (compute-entropy "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")))
  (true (approx-equal 1.00 (compute-entropy "01001011010000001010101110111001000011011100000100011101001100110101011100000000101100011011000001011001011010100111010000010110110111010110100010111011111000101101"))))

;; Helper functions
(defun approx-equal (a b)
  (< (abs (- a b)) 0.01))
