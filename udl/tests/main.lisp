(defpackage udl/tests/main
  (:use :cl
        :udl
        :rove))
(in-package :udl/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :udl)' in your Lisp.

(deftest test-arange
  (testing "Create a list with a range of values."
    (ok (equal '(3 4 5 6) (udl:arange 3 7 1)))))

(deftest test-vec-arange
  (testing "Create a vector with a range of values."
    (let ((vec (udl:vec-arange 3 7 1)))
      (loop :for i :from 0 :below 4
            :do (ok (= (+ i 3) (magicl:tref vec i 0)))))))

