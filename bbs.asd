(in-package :cl-user)
(defpackage bbs-asd
  (:use :cl :asdf))
(in-package :bbs-asd)

(defsystem bbs
  :version "0.1"
  :author "sugihara-kms"
  :license ""
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre
               :uiop
               :local-time
               :ironclad

               ;; for @route annotation
               :cl-syntax-annot

               ;; HTML Template
               :djula
               :cl-markup

               ;; for DB
               :datafly
               :sxql
               :mito)
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (load-op bbs-test))))
