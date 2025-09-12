(defsystem "udl"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("magicl")
  :components ((:module "src"
                :components
                ((:file "packages")
                 (:file "main")
                 (:file "utils")
                 (:file "linear")
                 (:file "ch4"))))
  :description ""
  :in-order-to ((test-op (test-op "udl/tests"))))

(defsystem "udl/tests"
  :author ""
  :license ""
  :depends-on ("udl"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for udl"
  :perform (test-op (op c) (symbol-call :rove :run c)))
