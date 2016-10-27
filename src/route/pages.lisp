(in-package :bbs.web)

;;; リクエストのURIに対応した処理

;; util
(defun assocdr (key alist)
  (cdr (assoc key alist :test #'string=)))

;; 掲示板の一覧表示（新規作成フォームも表示）
@route GET "/boards"
(defun show-boards (&key _parsed)
  (format t "掲示板一覧表示処理~%")
  (describe _parsed) ; URIパラメータ取得用

  (render #P"boards.html"
          (list "board_list" (mito:select-dao 'board))))

;; 板の追加
@route POST "/boards/create"
(defun create-board (&key _parsed)
  (format t "掲示板追加処理~%")
  (describe _parsed)

  (let ((newboard (assocdr "board" _parsed)))
    (describe newboard)
    (labels ((assoc-board (key) (assocdr key newboard)))
      (mito:insert-dao
       (make-instance 'board
                      :name (assoc-board "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
                      ))))
  (redirect "/boards"))

;; 板の編集(TODO)
@route POST "/boards/update"
(defun update-board (&key _parsed)
  (format t "掲示板編集処理")
  (describe _parsed)

  (redirect "/boards"))

;; 板の削除(TODO)
@route POST "/boards/delete"
(defun delete-board (&key _parsed)
  (format t "掲示板削除処理")
  (describe _parsed)

  (redirect "/boards"))

;; 選択した掲示板内のスレッド一覧表示
@route GET "/boards/*"
(defun show-threads (&key splat)
  (format t "スレッド一覧表示処理~%")
  (describe splat) ; URIパラメータ取得用

  (let ((boardid (parse-integer (car splat))))
    (render #P"threads.html"
            (append (list "board" (mito:find-dao 'board :id boardid))
                    (list "thread_list" (mito:select-dao 'thread (where (:= :boardid boardid))))))))

;; スレッドの追加
@route POST "/boards/*/create"
(defun create-thread (&key _parsed)
  (format t "スレッド追加処理~%")
  (describe _parsed)
  (describe (assocdr :splat _parsed))

  (let ((newthread (assocdr "thread" _parsed))
        (boardid (parse-integer (car (assocdr :splat _parsed)))))
    (describe newthread)
    (describe boardid)
    (labels ((assoc-thread (key) (assocdr key newthread)))
      (mito:insert-dao
       (make-instance 'thread
                      :boardid boardid
                      :name (assoc-thread "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
                      )))
    (redirect (format nil "/boards/~A" boardid))))

;; スレッドの編集(TODO)
@route POST "/boards/*/update"
(defun update-thread (&key _parsed)
  (format t "スレッド編集処理")
  (describe _parsed)

  (redirect "/boards"))

;; スレッドの削除(TODO)
@route POST "/boards/*/delete"
(defun delete-thread (&key _parsed)
  (format t "スレッド削除処理")
  (describe _parsed)

  (redirect "/boards"))

;; 選択したスレッド内のメッセージ一覧表示
@route GET "/boards/*/*"
(defun show-messages (&key splat)
  (format t "メッセージ一覧表示処理~%")
  (describe splat) ; URIパラメータ取得用

  (let ((threadid (parse-integer (second splat))))
    (render #P"messages.html"
            (append (list "thread" (mito:find-dao 'thread :id threadid))
                    (list "message_list" (mito:select-dao 'message (where (:= :threadid threadid))))))))

;; メッセージの追加
@route POST "/boards/*/*/create"
(defun create-message (&key _parsed)
  (format t "メッセージ追加処理~%")
  (describe _parsed)
  (describe (assocdr :splat _parsed))

  (let ((newmessage (assocdr "message" _parsed))
        (boardid (parse-integer (first (assocdr :splat _parsed))))
        (threadid (parse-integer (second (assocdr :splat _parsed)))))
    (describe newmessage)
    (describe threadid)
    (labels ((assoc-message (key) (assocdr key newmessage)))
      (mito:insert-dao
       (make-instance 'message
                      :threadid threadid
                      :name (assoc-thread "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
                      :mailaddress (assoc-thread "mailaddress")
                      :message (assoc-thread "message")
                      )))
    (redirect (format nil "/boards/~A/~A" boardid threadid))))

;; メッセージの編集(TODO)
@route POST "/boards/*/*/update"
(defun update-message (&key _parsed)
  (format t "メッセージ編集処理")
  (describe _parsed)

  (redirect "/boards"))

;; メッセージの削除(TODO)
@route POST "/boards/*/*/delete"
(defun delete-message (&key _parsed)
  (format t "メッセージ削除処理")
  (describe _parsed)

  (redirect "/boards"))


#|
;; CL−MARKUPの併用 (Djulaの{{ inner_contents|safe }}タグに表示可能)
@route GET "/markup_"
(defun show-boards (&key _parsed)
  (format t "一覧表示処理~%")
  (describe _parsed) ; URIパラメータ取得用

  (defvar inner-contents
    (cl-markup:markup
     (:head (:title "Welcome to Caveman!"))
     (:body "Blah blah blah.")
     (:ul
      (loop for name in '("Eitarow Fukamachi"
                          "Tomohiro Matsuyama")
         collect (cl-markup:markup (:li name))))
     (:p "Tiffany & Co.,Ltd")
     )
    )

  (render #P"boards.html"
          (append (list "board_list" (mito:select-dao 'bbs.db::board))
                  (list "inner_contents" inner-contents)))
  )
|#
