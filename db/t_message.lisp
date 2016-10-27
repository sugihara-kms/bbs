(in-package :bbs.db)

;;; メッセージテーブル

;; レスを管理するテーブル
(defclass message ()
  ((threadid :col-type (:varchar 32) ; スレid
             :initarg :threadid
             :accessor message-threadid)
   (name :col-type (:varchar 64) ; 投稿者名
         :initarg :name
         :accessor message-name)
   (mailaddress :col-type (:varchar 64) ; メール欄
         :initarg :mailaddress
         :accessor message-mailaddress)
   (message :col-type :text ; 本文
         :initarg :message
         :accessor message-message)
   (password :col-type (:varchar 64) ; 削除用パスワード
        :initarg :password
        :accessor message-password)
   (ipaddress :col-type (:varchar 32) ; 投稿者ＩＰ
            :initarg :ipaddress
            :accessor message-ipaddress)
   (remotehost :col-type (:varchar 64) ; 投稿者ホスト名
            :initarg :remotehost
            :accessor message-remotehost)
   (useragent :col-type (:varchar 64) ; 投稿者ＵＡ
            :initarg :useragent
            :accessor message-useragent))
   (:metaclass mito:dao-table-class))

;; シンボルのエクスポート
(export '(message
          message-threadid
          message-name
          message-mailaddress
          message-message
          message-password
          message-ipaddress
          message-remotehost
          message-useragent))
