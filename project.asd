(defsystem "#:my-system"
  :version "0.0.1"
  :author "kevin"
  :license "MIT"
  :depends-on (#:woo
               #:spinneret)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "./tests"))))

(defsystem "./tests"
  :author ""
  :license ""
  :depends-on ("."
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for ."
  :perform (test-op (op c) (symbol-call :rove :run c)))
