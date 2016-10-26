;;;;---------------------------------------------------------
;;;; サーバの起動(まずはこれ)
;;;;---------------------------------------------------------
(ql:quickload :bbs)
(in-package :bbs)
(start :server :woo :port 20011) ; ポートはnginx側で8080からのアクセスを受けつけている

(stop) ; サーバ停止コマンド

;;;;---------------------------------------------------------
;;;; DBの接続とデータ操作
;;;;---------------------------------------------------------
(ql:quickload :bbs)
(in-package :bbs)

;; CLUD例
(defvar sample-board1
  (make-instance 'board
        :boardid "talk-bbs"
        :name "雑談板"　 ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
        :defaultrange "10"
        :defaultrangeindex "5"
        :defaultrangethread "3"
        :homepage "開設者webページ"
        :css ""
        :showmessage ""))

(mito:insert-dao sample-board1)

(defvar sample-board2
  (make-instance 'board
        :boardid "test-bbs"
        :name "abc123あいう１２３"
        :defaultrange "10"
        :defaultrangeindex "5"
        :defaultrangethread "3"
        :homepage "開設者webページ"
        :css ""
        :showmessage ""))

(mito:insert-dao sample-board2)

;;;;---------------------------------------------------------
;;;; DBへのテーブル作成
;;;;---------------------------------------------------------
(ql:quickload :bbs)
(in-package :bbs)

;; テーブル定義の存在確認
(find-class 'board)
(find-class 'message)

;; クラス定義からテーブル定義を作成
(table-definition 'board)
(table-definition 'message)

;; テーブル作成
(ensure-table-exists 'board)
(ensure-table-exists 'message)
