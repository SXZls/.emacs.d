(mapcar
 (function (lambda (setting)
             (setq auto-mode-alist
                   (cons setting auto-mode-alist))))
 '(("\\.l\\'" . c-mode)
   ("\\.cl\\'" . lisp-mode)
   ("\\.lisp\\'" . lisp-mode)
   ("\\.scm\\'" . scheme-mode)
   ("\\.rkt\\'" . scheme-mode)
   ("\\.ss\\'" . scheme-mode)))
;; easy to add-mode-list.

(setq-default abbrev-mode t)
(setq save-abbrevs nil)
(setq my-abbrevs-file (expand-file-name
                       "lisp/abbrevs.el"
                       user-emacs-directory))
(if (file-exists-p my-abbrevs-file)
    (read-abbrev-file my-abbrevs-file))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook ((prog-mode . yas-minor-mode)
         (LaTeX-mode . yas-minor-mode))
  :config
  (yas-global-mode 1))

(use-package paredit
  :ensure t
  :hook ((scheme-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)
         (lisp-mode . paredit-mode)))

(provide 'init-edit)
