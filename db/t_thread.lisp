(in-package :bbs.db)

;;; スレッドテーブル

;; スレを管理するテーブル
(defclass thread ()
  ((boardid :col-type (:varchar 32) ; 板id
             :initarg :boardid
             :accessor thread-boardid)
   (name :col-type (:varchar 64) ; スレッド名
         :initarg :name
         :accessor thread-name))
   (:metaclass mito:dao-table-class))

;; シンボルのエクスポート
(export '(thread
          thread-boardid
          thread-name))
