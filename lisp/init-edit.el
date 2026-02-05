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

(global-set-key (kbd "M-/") 'dabbrev-expand)
(setq isearch-allow-scroll t)

(require 'cedet)
;(require 'semantic)
;(semantic-mode 1)
;(setq semanticdb-project-roots (list "/"))
;(defun senator-set()
;  (senator-mode 1))
;(add-hook 'c-mode-hook 'senator-set)
;(add-hook 'c++-mode-hook 'senator-set)
; is heavy,so read code use it

(add-hook 'haskell-mode-hook 'whitespace-mode)

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
