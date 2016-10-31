(in-package :bbs.web)

;;; リクエストのURIに対応した処理

;; 連想リストからキーを文字列比較して、結合された値を取得
(defun assocdr (key alist)
  (cdr (assoc key alist :test #'string=)))

;; パスワードのハッシュ値生成
(defun hash-password (password)
  (ironclad:byte-array-to-hex-string
   (ironclad:digest-sequence
    :sha256
    (ironclad:ascii-string-to-byte-array password))))

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 現在時刻をミリ秒付きで取得(SBCL限定)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun get-decode-universal-time-with-millisecond ()
  (multiple-value-bind (time ms)
      (sb-unix::system-real-time-values)
    (multiple-value-bind (s mm h d m y)
        (decode-universal-time (+ (encode-universal-time 0 0 0 1 1 1970 0) time))
      (values ms s mm h d m y))))

;; 現在時刻の表示用関数
(defun print-decode-universal-time-with-millisecond ()
  (multiple-value-bind (ms s mm h d m y)
    (get-decode-universal-time-with-millisecond)
    (format t "~A/~A/~A ~A:~A:~A.~A~%" y m d h mm s ms)))
|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CL−MARKUPの併用 (Djulaの{{ inner_contents|safe }}タグに表示可能)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
