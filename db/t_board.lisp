(in-package :bbs.db)

;;; ボードテーブル

;; 板を管理するテーブル
(defclass board ()
  ((name :col-type (:varchar 128) ; 板名
         :initarg :name
         :accessor board-name))
  (:metaclass mito:dao-table-class))

;; シンボルのエクスポート
(export '(board
          board-name))

