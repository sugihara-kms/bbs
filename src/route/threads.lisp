(in-package :bbs.web)

;; 選択した掲示板内のスレッド一覧表示
@route GET "/boards/:id"
(defun show-threads (&key id)
  (format t "スレッド一覧表示処理~%")
  (describe id) ; URIパラメータ取得用

  (let ((boardid (parse-integer id)))
    (render #P"threads.html"
            (append (list "board" (mito:find-dao 'board :id boardid))
                    (list "thread_list" (mito:select-dao 'thread (where (:= :boardid boardid))))))))

;; スレッドの追加
@route POST "/threads/create"
(defun create-thread (&key _parsed)
  (format t "スレッド追加処理~%")
  (describe _parsed)
  (describe (assocdr :splat _parsed))

  (let ((newthread (assocdr "thread" _parsed)))
    (describe newthread)
    (labels ((assoc-thread (key) (assocdr key newthread)))
      (let ((boardid (parse-integer (assoc-thread "boardid"))))
        (describe boardid)
        (mito:insert-dao
         (make-instance 'thread
                        :boardid boardid
                        :name (assoc-thread "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
                        )))
        (redirect (format nil "/boards/~A" boardid)))))

;; スレッドの編集(TODO:処理の実装)
@route POST "/threads/update"
(defun update-thread (&key _parsed)
  (format t "スレッド編集処理")
  (describe _parsed)

  (redirect "/boards"))

;; スレッドの削除(TODO:処理の実装)
@route POST "/threads/delete"
(defun delete-thread (&key _parsed)
  (format t "スレッド削除処理")
  (describe _parsed)

  (redirect "/boards"))
