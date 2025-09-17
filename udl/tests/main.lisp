(defpackage udl/tests/main
  (:use :cl
        :udl
        :udl.core
        :rove))
(in-package :udl/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :udl)' in your Lisp.

(deftest test-range
  (testing "Create a list with a range of values."
    (ok (equal '(3 4 5 6) (range 3 7 1)))))

(deftest test-vrange
  (testing "Create a vector with a range of values."
    (let ((vec (vrange 3 7 1))
          (key (make-mat '(1 4) '((3 4 5 6)))))
      (ok (mgl-mat:m= vec key)))))

(deftest test-mat-eq
  (testing "Matrix equals."
    (let ((mat (make-mat '(3 2) '((1 -1  2 -2  3 -3)))))
      (ok (mat-eq mat mat)))))

(deftest test-mat-not-eq
  (testing "Matrix not equals."
    (let ((mat1 (make-mat '(3 2) '((1  0  2  0  3  0))))
          (mat2 (make-mat '(3 2) '((1  1  2  0  3  0))))
          (mat3 (make-mat '(2 2) '((1  0  2  0)))))
      (ng (mat-eq mat1 mat2))
      (ng (mat-eq mat1 mat3))
      )))

(deftest test-relu
  (testing "Apply ReLU."
    (let ((mat (relu (make-mat '(3 2) '((1 -1  2 -2  3 -3)))))
          (key       (make-mat '(3 2) '((1  0  2  0  3  0)))))
      (ok (mat-eq mat key)))))

(deftest test-add-ones-row
  (testing "Add row of ones to matrix."
    (let ((mat (add-ones-row (make-mat '(3 2) '((1 -1  2 -2  3 -3)))))
          (key               (make-mat '(4 2) '((1  1  1 -1  2 -2  3 -3)))))
      (ok (mat-eq mat key)))))

(deftest test-linear
  (testing "Test linear combination: b + wx."
    (let ((x (make-mat '(2 2) '((1 1 2 4))))
          (w (make-mat '(3 3) '((1 1 1 1 2 2 1 3 3))))
          (y (make-mat '(3 2) '((4 6 7 11 10 16)))))
      (ok (mat-eq (linear x w) y)))))

