(uiop:define-package udl
  (:use #:cl)
  (:export #:main
           #:arange #:vec-arange))

(in-package #:udl)

(defun main ()
  (let ((x (vec-arange 1 20 1 :layout 'row)))
    (short-print-vec x)))
