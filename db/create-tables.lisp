;;;;---------------------------------------------------------
;;;; DBへのテーブル作成
;;;;---------------------------------------------------------

;; コネクション確立
(mito:connect-toplevel :mysql :database-name "bbs_db" :username "root" :password "Kmskms_0123")

;; テーブル定義
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

(mito:table-definition 'board)

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

(mito:table-definition 'message)

;; テーブル定義の存在確認
(find-class 'board)
(find-class 'message)

;; テーブル作成
(mito:ensure-table-exists 'board)
(mito:ensure-table-exists 'message)

;; コネクション切断
(mito:disconnect-toplevel)
