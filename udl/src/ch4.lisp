
(in-package #:udl.ch4)

(defun test-linear (title x theta phi)
  (let* ((h1 (linear x theta #'relu))
         (y  (linear h1 phi)))
    (format t " ~&y~&")
    (print-mat y)))

(defun test-networks ()
  (let* ((x (vec-arange -1 1 0.1))
         (theta1 (magicl:from-list '( 0.0  -1.0
                                      0.0   1.0
                                     -0.67  1.0)
                                   '(3 2)))
         (phi1   (magicl:from-list '( 1.0  -2.0  -3.0  9.3)
                                   '(1 4)))
         (theta2 (magicl:from-list '(-0.6  -1.0
                                      0.2   1.0
                                     -0.5   1.0)
                                   '(3 2)))
         (phi2   (magicl:from-list '( 0.5  -1.0  -1.5  2.0)
                                   '(1 4)))
         (y1 (test-linear "Output1" x theta1 phi1))
    )

    (format t " ~&theta1:~&")
    (print-mat theta1)
    (format t " ~&phi1:~&")
    (print-mat phi1)
    (format t " ~&theta2:~&")
    (print-mat theta2)
    (format t " ~&phi2:~&")
    (print-mat phi2)
    
    (test-linear "Output2" x theta2 phi2)
    (test-linear "Output3" y1 theta2 phi2)
    ))

(defun run ()
  (test-networks()))
