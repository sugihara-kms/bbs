(in-package :cl-user)
(defpackage bbs.db
  (:use :cl)
  (:import-from :bbs.config
                :config)
  (:import-from :datafly
                :*connection*
                :connect-cached)
  (:export :connection-settings
           :db
           :with-connection))
(in-package :bbs.db)

(defun connection-settings (&optional (db :maindb))
  (cdr (assoc db (config :databases))))

(defun db (&optional (db :maindb))
  (apply #'connect-cached (connection-settings db)))

(defmacro with-connection (conn &body body)
  `(let ((*connection* ,conn))
     ,@body))

;; DB接続
(load "db/env.lisp")
(load "db/connect-db.lisp")

;; テーブル定義
(load "db/t_board.lisp")
(load "db/t_message.lisp")
