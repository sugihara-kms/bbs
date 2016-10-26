(in-package :bbs.web)

;;; リクエストのURIに対応した処理

;; 掲示板の一覧画面（TODO:新規作成フォームをつける。削除や編集について専用画面を作るかは要検討）
@route GET "/boards"
(defun show-boards (&key _parsed)
  ;;一覧表示処理
  (format t "一覧表示処理~%")
  (format t "1 ~S~%" _parsed) ; URIパラメータ取得用

  (format nil "~A"  (mapcar #'bbs.db::board-name (mito:select-dao 'bbs.db::board))))
                                        ;(render #P"xsboards.html" djula-context) ; パラメータは連想リスト

@route POST "/boards/create"
(defun create-board (&key _parsed)
  ;;追加処理
  (format t "追加処理~%")
  (format t "1 ~S~%" _parsed)
  (format t "2 ~S~%" (cdr (assoc "board" _parsed :test #'string=)))
  (format t "3 ~S~%" (cdr (assoc "name" (cdar _parsed) :test #'string=)))

  (let ((board-value
         (cdr (assoc "board" _parsed :test #'string=))))
    (defun assoc-board (key)
      (cdr (assoc key board-value :test #'string=)))

    (defvar new-board
      (make-instance 'bbs.db::board
        :boardid (assoc-board "boardid")
        :name (assoc-board "name") ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
        :defaultrange (assoc-board "defaultrange")
        :defaultrangeindex (assoc-board "defaultrangeindex")
        :defaultrangethread (assoc-board "defaultrangethread")
        :homepage (assoc-board "homepage")
        :css (assoc-board "css")
        :showmessage (assoc-board "showmessage")))

    (mito:insert-dao new-board)

  (render #P"boards.html")))

@route POST "/boards/update"
(defun update-board ()
  ;; 編集処理
  (format t "編集処理")
  (render #P"boards.html"))

@route POST "/boards/delete"
(defun delete-board ()
  ;; 削除処理
  (format t "削除処理")
  (render #P"boards.html"))

;; 選択した掲示板内のスレッド一覧画面（）
@route GET "/boards/"
(defun index ()
  (render #P"boards.html"))

@route GET "/hello"
(defun say-hello (&key (|name| "Guest"))
  (format nil "Hello, ~A" |name|)
  (render #P"sample.html"))
