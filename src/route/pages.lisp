(in-package :bbs.web)

;;; リクエストのURIに対応した処理

;; util
(defun assocdr (key alist)
  (cdr (assoc key alist :test #'string=)))

;; 掲示板の一覧表示（新規作成フォームも表示）
@route GET "/boards"
(defun show-boards (&key _parsed)
  (format t "一覧表示処理~%")
  (describe _parsed) ; URIパラメータ取得用

  (render #P"boards.html"
          (list "board_list" (mito:select-dao 'board)))
 )
;; 板の追加
@route POST "/boards/create"
(defun create-board (&key _parsed)
  (format t "追加処理~%")
  (describe _parsed)

  (let ((board-list (assocdr "board" _parsed)))
    (describe board-list)
    (labels ((assoc-board (key) (assocdr key board-list)))
      (mito:insert-dao
        (make-instance 'board
          :name (assoc-board "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
          ))))
  (redirect "/boards"))

;; 板の編集
@route POST "/boards/update"
(defun update-board (&key _parsed)
  (format t "編集処理")
  (describe _parsed)

  (redirect "/boards"))

;; 板の削除
@route POST "/boards/delete"
(defun delete-board (&key _parsed)
  (format t "削除処理")
  (describe _parsed)

  (redirect "/boards"))

;; 選択した掲示板内のスレッド一覧表示
@route GET "/messages"
(defun show-messages (&key _parsed)
  (format t "一覧表示処理~%")
  (describe _parsed) ; URIパラメータ取得用

  (render #P"messages.html"
          (list "message_list" (mito:select-dao 'bbs.db::message)))
 )



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
