(setq-default abbrev-mode t)
(setq save-abbrevs nil)
(setq my-abbrevs-file "~/.emacs.d/abbrevs.el")
(if (file-exists-p "~/.emacs.d/abbrevs.el")
    (read-abbrev-file "~/.emacs.d/abbrevs.el"))

(provide 'init-edit)
