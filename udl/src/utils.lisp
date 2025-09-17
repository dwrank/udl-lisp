
(in-package #:udl.core)

;; make sure tail recursion optimization is enabled
(proclaim '(optimize speed))

(defun range (start stop step &key (lst nil))
  "Create a list from start up to, but not including stop,
  in step increments."           
  (if (>= start stop)           
      (reverse lst)
      (range (+ start step) stop step :lst (cons start lst))))

(defun arange (start stop step &key (layout :row))
  "Create an array from start up to, but not including stop,
  in step increments."
  (let* ((len (floor (/ (- stop start) step)))
         (arr (aops:generate (lambda (i) (+ start (* i step))) len :position)))
    (if (eq layout :col)
        (aops:reshape arr (list len 1))
        (aops:reshape arr (list 1 len)))))

(defun vrange (start stop step &key (layout :row))
  "Create a vector from start up to, but not including stop,
  in step increments."
  (mgl-mat:array-to-mat (arange start stop step :layout layout) :ctype :float))

(defun vec-layout (vec)
  (let ((dims (mgl-mat:mat-dimensions vec)))
    (if (equal 1 (first dims)) :row :col)))

(defun vec-length (vec)
  (let ((layout (vec-layout vec))
	(dims (mgl-mat:mat-dimensions vec)))
    (if (eq layout :col) (first dims) (second dims))))

(defun sub-vec (vec start end)
  (let* ((end (min end (vec-length vec)))
	 (a (mgl-mat:mat-to-array vec)))
    (mgl-mat:array-to-mat (aops:partition a start end))))

(defun mat-eq (m1 m2)
  (let ((s1 (mgl-mat:mat-dimensions m1))
        (s2 (mgl-mat:mat-dimensions m2)))
    (if (not (equal s1 s2))
        nil
        (mgl-mat:m= m1 m2))))

(defun make-mat (dims contents)
  (mgl-mat:make-mat dims :initial-contents contents :ctype :float))
