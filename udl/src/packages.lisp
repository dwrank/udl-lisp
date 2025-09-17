
(defpackage udl.core
  (:use #:cl)
  (:export #:sub-vec
           #:range #:arange #:vrange
           #:make-mat #:mat-eq
           #:linear #:relu #:add-ones-row
           ))

(defpackage udl.ch4
  (:use #:cl #:udl.core)
  (:export #:run))

(uiop:define-package udl
  (:use #:cl #:udl.core)
  (:export #:main))

