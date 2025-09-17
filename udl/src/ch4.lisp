
(in-package #:udl.ch4)

(defun test-linear (title x theta phi)
  (let ((h1 (linear x theta #'relu)))
    (linear h1 phi)))

(defun print-mat (name mat)
  (format t ">>> ~A~&~A~&" name mat))

(defun test-networks ()
  (let* ((x (vrange -1 1 0.1))
         (theta1 (make-mat '(3 2)
                           '(( 0.0  -1.0 
                               0.0   1.0 
                              -0.67  1.0 ))))
         (phi1   (make-mat '(1 4)
                           '(( 1.0  -2.0  -3.0  9.3))))
         (theta2 (make-mat '(3 2)
                           '((-0.6  -1.0
                               0.2   1.0
                              -0.5   1.0 ))))
         (phi2   (make-mat '(1 4)
                           '(( 0.5  -1.0  -1.5  2.0))))
         (y1 (test-linear "Output1" x theta1 phi1))
         (y2 (test-linear "Output2" x theta2 phi2))
         (y3 (test-linear "Output3" y1 theta2 phi2))
    )

    (print-mat "theta1" theta1)
    (print-mat "phi1" phi1)
    (print-mat "y1" y1)
    (terpri)

    (print-mat "theta2" theta2)
    (print-mat "phi2" phi2)
    (print-mat "y2" y2)
    (terpri)

    (print-mat "y3" y3)
    
    (values)
    ))

(defun run ()
  (test-networks))
