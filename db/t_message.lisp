(in-package :bbs.db)

;;; メッセージテーブル

;; スレに紐づくレスを管理するテーブル
(defclass message ()
  ((serialid :col-type :integer
            :initarg :serialid
            :accessor message-serialid)
   (boardid :col-type (:varchar 32)
            :initarg :boardid
            :accessor message-boardid)
   (posteddate :col-type :timestamp
            :initarg :posteddate
            :accessor message-posteddate)
   (name :col-type (:varchar 64)
         :initarg :name
         :accessor message-name)
   (mailaddress :col-type (:varchar 64)
         :initarg :mailaddress
         :accessor message-mailaddress)
   (url :col-type (:varchar 64)
        :initarg :url
        :accessor message-url)
   (subject :col-type (:varchar 128)
         :initarg :subject
         :accessor message-subject)
   (message :col-type :text
         :initarg :message
         :accessor message-message)
   (altermessage :col-type :text
         :initarg :altermessage
         :accessor message-altermessage)
   (password :col-type (:varchar 64)
        :initarg :password
        :accessor message-password)
   (preformatted :col-type :bool
        :initarg :preformatted
        :accessor message-preformatted)
   (deleted :col-type :bool
        :initarg :deleted
        :accessor message-deleted)
   (parent :col-type :integer
            :initarg :parent
            :accessor message-parent)
   (top :col-type :integer
            :initarg :top
            :accessor message-top)
   (ipaddress :col-type (:varchar 32)
            :initarg :ipaddress
            :accessor message-ipaddress)
   (remotehost :col-type (:varchar 64)
            :initarg :remotehost
            :accessor message-remotehost)
   (useragent :col-type (:varchar 64)
            :initarg :useragent
            :accessor message-useragent))
   (:metaclass mito:dao-table-class)
   (:primary-key serialid boardid))

#|
;; シンボルのエクスポート
　　@export 使いたいな
|#
