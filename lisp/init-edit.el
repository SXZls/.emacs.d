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
(setq my-abbrevs-file "~/.emacs.d/lisp/abbrevs.el")
(if (file-exists-p "~/.emacs.d/lisp/abbrevs.el")
    (read-abbrev-file "~/.emacs.d/lisp/abbrevs.el"))

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
