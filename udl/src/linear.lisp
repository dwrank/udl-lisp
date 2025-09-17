
(in-package #:udl.core)

(defun relu (mat)
  (let ((result (mgl-mat:make-mat (mgl-mat:mat-dimensions mat) :ctype :float)))
    (mgl-mat:map-mats-into result (lambda (a b) (max a b)) result mat)
    result))

(defun add-ones-row (x)
  (let* ((dims (mgl-mat:mat-dimensions x))
         (cols (second dims))
         (top (mgl-mat:make-mat (list 1 cols) :initial-element 1 :ctype :float)))
    (mgl-mat:stack 0 (list top x) :ctype :float)))

(defun linear (xin weights &optional (activation nil))
  (let* ((x (add-ones-row xin))
         (y (mgl-mat:m* weights x)))
    (if activation (funcall activation y) y)))

