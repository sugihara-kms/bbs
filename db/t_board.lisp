(in-package :bbs.db)

;;; ボードテーブル

;; 板に紐づくスレを管理するテーブル
(defclass board ()
  ((boardid :col-type (:varchar 32)
            :primary-key :t
            :initarg :boardid
            :accessor board-boardid)
   (name :col-type (:varchar 128)
         :initarg :name
         :accessor board-name)
   (defaultrange :col-type :integer
                 :initarg :defaultrange
                 :accessor board-defaultrange)
   (defaultrangeindex :col-type :integer
                      :initarg :defaultrangeindex
                      :accessor board-defaultrangeindex)
   (defaultrangethread :col-type :integer
                       :initarg :defaultrangethread
                       :accessor board-defaultrangethread)
   (homepage :col-type (:varchar 128)
             :initarg :homepage
             :accessor board-homepage)
   (css :col-type (:varchar 64)
        :initarg :css
        :accessor board-css)
   (showmessage :col-type (:varchar 64)
                :initarg :showmessage
                :accessor board-showmessage))
  (:metaclass mito:dao-table-class))

#|
;; シンボルのエクスポート
(export '(board
          board-boardid
          board-name
          board-defaultrange
          board-defaultrangeindex
          board-defaultrangethread
          board-homepage
          board-css
          board-showmessage))
|#
