
(in-package #:udl)

(defun main ()
  (let ((x (vec-arange 1 20 1 :layout 'row)))
    (short-print-vec x)
    (udl.ch4:run)))
