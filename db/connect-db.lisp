(in-package :bbs.db)

;; DBへの接続を確立する
(defun connect-database ()
  (mito:connect-toplevel :mysql
                    :database-name *database-name*
                    :username *database-user-name*
                    :password *database-password*))

(connect-database)

; (mito:disconnect-toplevel) ; コネクション切断コマンド
