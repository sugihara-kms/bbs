(in-package :cl-user)
(defpackage bbs-test-asd
  (:use :cl :asdf))
(in-package :bbs-test-asd)

(defsystem bbs-test
  :author "sugihara-kms"
  :license ""
  :depends-on (:bbs
               :prove)
  :components ((:module "t"
                :components
                ((:file "bbs"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
