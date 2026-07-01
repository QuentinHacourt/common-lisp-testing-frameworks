(defpackage :entropy
  (:use :cl)
  (:export #:unique-symbols #:count-appearances #:str-len #:compute-probabilities #:compute-entropy))

(in-package :entropy)

(defun unique-symbols (str)
  "Finds all the different symbols in a list and returns them as a list."
  (let ((symbols '()))
    (loop for char across str
          unless (member char symbols)
            do (push char symbols))
    (reverse symbols)))

(defun count-appearances (symbols str)
  "Counts how often each symbol in the list appears in the original string."
  (loop for symbol in symbols
        collect (list symbol
                      (count symbol str :test #'eql))))

(defun str-len (str)
  "Counts the length of a string."
  (let ((ctr 0))
    (loop for char across str
          do (incf ctr))
    ctr))

(defun compute-probabilities (frequencies len)
  "given the frequencies and the total length, computes the probability of a symbol appearing."
  (loop for pair in frequencies
        for symbol = (first pair)
        for count = (second pair)
        collect (list symbol (/ (float count) len))))

(defun compute-entropy (str)
  "Computes the entropy of any given string."
  (let* ((symbols (unique-symbols str))
         (frequencies (count-appearances symbols str))
         (len (str-len str))
         (probabilities (compute-probabilities frequencies len)))
    (- (loop for (symbol p) in probabilities
             sum (* p (log p 2))))))
