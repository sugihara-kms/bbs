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
(use-package :bbs.db)
(use-package :mito)

;; CLUD例
(insert-dao
 (make-instance 'board
                :name "ニュース" ;UTF-8 -> ISO8859-1 -> UTF-8と変換されているようで文字が化ける。。。
 ))

(insert-dao
 (make-instance 'board
                :name "ラウンジ"
 ))

;; util
(defun id (table name)
  (object-id (find-dao table :name name))) ; 主キーはidのみで、同名を許容したい。従ってこのid取得方法はあくまで簡易版

(insert-dao
 (make-instance 'thread
                :boardid (id 'board "ニュース")
                :name "【ニュース】テストスレ"
 ))
(insert-dao
 (make-instance 'thread
                :boardid (id 'board "ニュース")
                :name "【ニュース】テストスレ＃２"
 ))
(insert-dao
 (make-instance 'thread
                :boardid (id 'board "ラウンジ")
                :name "【ラウンジ】テストスレ"
 ))
(insert-dao
 (make-instance 'thread
                :boardid (id 'board "ラウンジ")
                :name "【ラウンジ】テストスレ＃２"
 ))
(delete-dao
 (make-instance 'thread
                :id 6 ; mitoでは外部キー制約を扱わないため、紐づくテーブルを削除するマクロにする必要がある。
                      ; また、削除したauto-pkは欠番となる。
 ))

;; パスワードはハッシュ化して保存したいね。比較時もハッシュ値で。
(insert-dao
 (make-instance 'message
                :threadid (id 'thread "【ラウンジ】テストスレ")
                :name "名無し"
                :mailaddress ":sage"
                :message "初カキコ"
                :password "pass"
                :ipaddress "192.16.0.1"
                :remotehost "p5312095-ipngnfx01marunouchi.tokyo.ocn.ne.jp"
                :useragent "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36 OPR/32.0.1948.25"
(insert-dao
 (make-instance 'message
                :threadid (id 'thread "【ラウンジ】テストスレ")
                :name "名無し"
                :mailaddress ":sage"
                :message "１乙"
                :password "pass"
                :ipaddress "192.16.0.2"
                :remotehost "p5312095-ipngnfx01marunouchi.tokyo.ocn.ne.jp"
                :useragent "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36 OPR/32.0.1948.25"
 ))



;;;;---------------------------------------------------------
;;;; DBへのテーブル作成
;;;;---------------------------------------------------------
(ql:quickload :bbs)
(in-package :bbs)
(use-package :bbs.db)
(use-package :mito)

;; テーブル定義の存在確認
(find-class 'board)
(find-class 'thread)
(find-class 'message)

;; クラス定義からテーブル定義を作成
(table-definition 'board)
(table-definition 'thread)
(table-definition 'message)

;; テーブル作成
(ensure-table-exists 'board)
(ensure-table-exists 'thread)
(ensure-table-exists 'message)
