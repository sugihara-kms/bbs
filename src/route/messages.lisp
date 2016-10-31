(in-package :bbs.web)

;; 選択したスレッド内のメッセージ一覧表示
@route GET "/threads/:id"
(defun show-messages (&key id)
  (format t "メッセージ一覧表示処理~%")
  (describe id) ; URIパラメータ取得用

  ;; データ整形
  (defun message-format (message_list)
    (if (null message_list)
        nil
        (progn (dolist (m message_list message_list)
                 (setf (message-ipaddress m) (hash-password (message-ipaddress m)))
                 (setf (message-timestamp m) (local-time:parse-timestring (message-timestamp m)))))))

  (let ((threadid (parse-integer id)))
    (render #P"messages.html"
            (append (list "thread" (mito:find-dao 'thread :id threadid))
                    (list "message_list" (message-format (mito:select-dao 'message (where (:= :threadid threadid)))))))))

;; メッセージの追加
@route POST "/messages/create"
(defun create-message (&key _parsed)
  (format t "メッセージ追加処理~%")
  (describe _parsed)
  (describe (assocdr :splat _parsed))

  (let ((newmessage (assocdr "message" _parsed)))
    (describe newmessage)
    (labels ((assoc-message (key) (assocdr key newmessage)))
      (let ((threadid (parse-integer (assoc-message "threadid"))))
        (mito:insert-dao
          (make-instance 'message
                         :threadid threadid
                         :name (assoc-message "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
                         :mailaddress (assoc-message "mailaddress")
                         :body (assoc-message "body")
                         :ipaddress (gethash '"x-real-ip" (request-headers *request*))
                         :timestamp (local-time:format-timestring nil (local-time:now))))
        (redirect (format nil "/threads/~A" threadid))))))

;; メッセージの編集(TODO)
@route POST "/messages/update"
(defun update-message (&key _parsed)
  (format t "メッセージ編集処理")
  (describe _parsed)

  (redirect "/threads/"))

;; メッセージの削除(TODO)
@route POST "/messages/delete"
(defun delete-message (&key _parsed)
  (format t "メッセージ削除処理")
  (describe _parsed)

  (redirect "/threads/"))
