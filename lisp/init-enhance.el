(setq visible-bell t)
(electric-pair-mode t)
(setq display-line-numbers-type 'visual)
(global-display-line-numbers-mode t)
(column-number-mode 1)

(which-key-mode 1)

(ido-mode 1)

(set-face-attribute
 'default nil
 :background (if (display-graphic-p) "darkslategray" "black")
 :foreground (if (display-graphic-p) "wheat" "white"))

(setq kill-ring-max 200)
;; paste and cut board

(setq-default indent-tabs-mode nil)

(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;; set  sentence-end can read chiese code,dont need to add two space after the fill

(setq enable-recursive-minibuffers t)

(setq scroll-margin 3
      scroll-conservatively 10000)
;; 

(mouse-avoidance-mode 'animate)
;; cursor avoid mouse

(setq frame-title-format "GNU Emacs@%b")
;;change title

(auto-image-file-mode)
;;open picture

(put 'set-goal-column 'disabled nil)
; (put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)
;; version control

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
;; easy to add-to-list.

(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

(setq custom-file (expand-file-name "custom.el" (concat user-emacs-directory "lisp/")))
(when(file-exists-p custom-file)
 (load-file custom-file))

(use-package magit
  :commands (magit-status magit-blame magit-log-buffer-file))

(use-package no-littering
  :ensure t)

(use-package paredit
  :ensure t
  :hook ((scheme-mode . paredit-mode)
	 (emacs-lisp-mode . paredit-mode)
	 (lisp-mode . paredit-mode)))

(provide 'init-enhance)
