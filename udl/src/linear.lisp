
(in-package #:udl.core)

(defun relu (mat)
  (let ((zeros (magicl:zeros (magicl:shape mat) :type 'single-float)))
    (magicl:.max zeros mat)))

(defun add-ones-row (x)
  (let* ((xshape (magicl:shape x))
         (xcols (second xshape))
         (xtop (magicl:ones (list 1 xcols) :type 'single-float)))
    (magicl:vstack (list xtop x))))

(defun linear (xin weights &optional (activation nil))
  (let* ((x (add-ones-row xin))
         (y (magicl:@ weights x)))
    (if activation (funcall activation y) y)))

