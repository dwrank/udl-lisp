(defpackage udl/tests/main
  (:use :cl
        :udl
        :udl.core
        :rove))
(in-package :udl/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :udl)' in your Lisp.

(deftest test-arange
  (testing "Create a list with a range of values."
    (ok (equal '(3 4 5 6) (arange 3 7 1)))))

(deftest test-vec-arange
  (testing "Create a vector with a range of values."
    (let ((vec (vec-arange 3 7 1)))
      (loop :for i :from 0 :below 4
            :do (ok (= (+ i 3) (magicl:tref vec 0 i)))))))

(deftest test-mat-eq
  (testing "Matrix equals."
    (let ((mat (magicl:from-list '(1 -1  2 -2  3 -3) '(3 2) :type 'single-float)))
      (ok (mat-eq mat mat)))))

(deftest test-mat-not-eq
  (testing "Matrix not equals."
    (let ((mat1 (magicl:from-list '(1 -1  2 -2  3 -3) '(3 2) :type 'single-float))
          (mat2 (magicl:from-list '(1  0  2  0  3  0) '(3 2) :type 'single-float)))
      (ng (mat-eq mat1 mat2)))))

(deftest test-relu
  (testing "Apply RELu."
    (let ((mat (relu (magicl:from-list '(1 -1  2 -2  3 -3) '(3 2) :type 'single-float)))
          (key (magicl:from-list '(1  0  2  0  3  0) '(3 2) :type 'single-float)))
      (ok (mat-eq mat key)))))

(deftest test-add-ones-row
  (testing "Add row of ones to matrix."
    (let ((mat (add-ones-row (magicl:from-list '(1 -1  2 -2  3 -3) '(3 2) :type 'single-float)))
          (key (magicl:from-list '(1 1 1 -1  2 -2  3 -3) '(4 2) :type 'single-float)))
      (ok (mat-eq mat key)))))

(deftest test-linear
  (testing "Test linear combination: b + wx."
    (let ((x (magicl:from-list '(1 1 2 4) '(2 2) :type 'single-float))
          (w (magicl:from-list '(1 1 1 1 2 2 1 3 3) '(3 3) :type 'single-float))
          (y (magicl:from-list '(4 6 7 11 10 16) '(3 2) :type 'single-float)))
      (ok (mat-eq (linear x w) y)))))

