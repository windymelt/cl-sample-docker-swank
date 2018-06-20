(in-package :cl-user)
(defpackage hogeapplication-test-asd
  (:use :cl :asdf))
(in-package :hogeapplication-test-asd)

(defsystem hogeapplication-test
  :author ""
  :license ""
  :depends-on (:hogeapplication
               :prove)
  :components ((:module "t"
                :components
                ((:file "hogeapplication"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
