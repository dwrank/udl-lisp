
(defpackage udl.core
  (:use #:cl)
  (:export #:split-int #:split-vec #:short-print-vec #:print-mat
           #:arange #:vec-arange
           #:linear #:relu #:add-ones-row
           #:mat-eq))

(defpackage udl.ch4
  (:use #:cl #:udl.core)
  (:export #:run))

(uiop:define-package udl
  (:use #:cl #:udl.core)
  (:export #:main))

