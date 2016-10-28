(in-package :bbs.web)

;; 掲示板の一覧表示（新規作成フォームも表示）
@route GET "/boards"
(defun show-boards (&key _parsed)
  (format t "掲示板一覧表示処理~%")
  (describe _parsed) ; URIパラメータ取得用(※未使用)

  (render #P"boards.html"
          (list "board_list" (mito:select-dao 'board))))

;; 板の追加
@route POST "/boards/create"
(defun create-board (&key _parsed)
  (format t "掲示板追加処理~%")
  (describe _parsed)

  (let ((newboard (assocdr "board" _parsed)))
    (describe newboard)
    (labels ((assoc-board (key)
               (assocdr key newboard)))
      (mito:insert-dao
       (make-instance 'board
                      :name (assoc-board "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
                      ))))
  (redirect "/boards"))

;; 板の編集(TODO:処理の実装)
@route POST "/boards/update"
(defun update-board (&key _parsed)
  (format t "掲示板編集処理")
  (describe _parsed)

  (redirect "/boards"))

;; 板の削除(TODO:処理の実装)
@route POST "/boards/delete"
(defun delete-board (&key _parsed)
  (format t "掲示板削除処理")
  (describe _parsed)

  (redirect "/boards"))
