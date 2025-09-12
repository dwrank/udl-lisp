
(in-package #:udl.core)

;; make sure tail recursion optimization is enabled
(proclaim '(optimize speed))

(defun arange (start stop step &key (lst nil))
  "Create a list from start up to, but not including stop,
  in step increments."           
  (if (>= start stop)           
      (reverse lst)
      (arange (+ start step) stop step :lst (cons start lst))))

(defun create-vec-shape (lst layout)
  (if (eq layout 'column)
      (list (list-length lst) 1)
      (list 1 (list-length lst))))
      
(defun vec-arange (start stop step &key (layout 'row))
  "Create a column vector from start up to, but not including stop,
  in step increments."
  (let* ((lst (arange start stop step))
         (shape (create-vec-shape lst layout)))
    (magicl:from-list lst shape :type 'single-float)))

(defun vec-layout (vec)
  (let ((shape (magicl:shape vec)))
    (if (equal 1 (first shape)) 'row 'column)))

(defun vec-length (vec)
  (let ((layout (vec-layout vec))
	(shape (magicl:shape vec)))
    (if (eq layout 'column) (first shape) (second shape))))

(defun slice-vec-pos (vec start end)
  (if (eq (vec-layout vec) 'column)
      ;; slice vec from (start-row start-col)
      ;; up to but not including (end-row end-col)
      (list (list start 0) (list end 1))
      (list (list 0 start) (list 1 end))))

(defun slice-vec (vec start end)
  (let* ((end (min end (vec-length vec)))
	 (pos (slice-vec-pos vec start end)))
    (apply #'magicl:slice vec pos)))

(defun print-vec (vec)
  (let ((len (vec-length vec)))
    (labels ((print-index (vec i)
                        (if (< i len)
                          (progn (format t "~F " (magicl:tref vec i 0))
                                 (print-index vec (1+ i))))))
    (print-index vec 0))))

(defun print-mat (mat)
  (format t "~A~&" mat))

(defun split-int (n)
  (if (evenp n)
      (let ((half (/ n 2)))
        (values half half))
      (let ((half (truncate n 2)))
        (values (1+ half) half))))

(defun split-vec (vec &optional (len1 5) (len2 5))
  (let ((vlen (vec-length vec)))
    (if (<= vlen (+ len1 len2))
        (values vec nil)
        (values (slice-vec vec 0 len1) (slice-vec vec (- vlen len2) vlen)))))

(defun short-print-vec (vec &optional (len 10))
  (multiple-value-bind (len1 len2) (split-int len)
    (multiple-value-bind (v1 v2) (split-vec vec len1 len2)
      (print-vec v1)
      (if v2
          (progn (format t "... ")
                 (print-vec v2)))
      (terpri))))

(defun print-vec-info (name vec)
  (princ (list (format nil "~&##### ~A #####~&" name)
	       (format nil "~&~A~&" vec)
	       (format nil "~&layout: ~A~&" (vec-layout vec))
	       (format nil "~&length: ~A~&" (vec-length vec)))))
 
(defun mat-eq (m1 m2)
  (let ((s1 (magicl:shape m1))
        (s2 (magicl:shape m2)))
    (if (not (equal s1 s2))
        nil
        (labels ((elem-eq (m1 m2 rows cols row col)
                   (cond ((>= col cols) (elem-eq m1 m2 rows cols (1+ row) 0))
                         ((>= row rows) 'T)
                         ((= (magicl:tref m1 row col) (magicl:tref m2 row col))
                          (elem-eq m1 m2 rows cols row (1+ col)))
                         (t nil))))
          (elem-eq m1 m2 (first s1) (second s1) 0 0)))))

