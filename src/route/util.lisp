(in-package :bbs.web)

;;; リクエストのURIに対応した処理

;; 連想リストからキーを文字列比較して、結合された値を取得
(defun assocdr (key alist)
  (cdr (assoc key alist :test #'string=)))

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
