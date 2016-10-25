;;;;---------------------------------------------------------
;;;; フレームワークのインストールとスケルトン作成（初回のみ）
;;;;---------------------------------------------------------
(ql:quickload :caveman2)

(caveman2:make-project #P"/home/sugihara/projects/practice/bbs"
                       :author "sugihara-kms")
