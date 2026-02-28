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

;(require 'cedet)
;(require 'semantic)
;(semantic-mode 1)
;(setq semanticdb-project-roots (list "/"))
;(defun senator-set()
;  (senator-mode 1))
;(add-hook 'c-mode-hook 'senator-set)
;(add-hook 'c++-mode-hook 'senator-set)
; is heavy,so read code use it

(add-hook 'haskell-mode-hook 'whitespace-mode)

;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;
(ensure-installed 'yasnippet)
;(require 'yasnippet)
(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'Latex-mode-hook 'yas-minor-mode)

;;;;;;;;;;
;; paredit
;;;;;;;;;;
(ensure-installed 'paredit)

(;require 'paredit
 )
(eval-when-compile (require 'cl))

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

(put 'paredit-forward-delete 'delete-selection 'supersede)
(put 'paredit-backward-delete 'delete-selection 'supersede)
(put 'paredit-newline 'delete-selection t)

(provide 'init-edit)
