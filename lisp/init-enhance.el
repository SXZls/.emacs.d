;; -*- lexical-binding: t; -*-

(recentf-mode 1) ;; recentf file
(save-place-mode 1)
(setq uniquify-buffer-name-style 'forward) ;; uniquify file name
(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq tab-always-indent 'complete)

(setq visible-bell 1)
(electric-pair-mode 1)
;(global-display-line-numbers-mode t)
(column-number-mode 1)
(ido-mode 1)
(global-font-lock-mode 1)
(transient-mark-mode 1)
(auto-compression-mode 1)
(auto-fill-mode 1)
(prefer-coding-system 'utf-8)
(setq track-eol 1)
(setq kill-whole-line 1)

(setq sentence-end
      "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
      sentence-end-double-space nil)
;; Setting sentence-end can recognize Chinese punctuation.
;There is no need to insert two spaces when filling.

(setq enable-recursive-minibuffers t)

(setq scroll-conservatively 97
      scroll-preserve-screen-position t)

(auto-image-file-mode)
;;open picture

;; treesit
(setq treesit-extra-load-path (executable-find "tree-sitter"))

(put 'set-goal-column 'disabled nil)
; (put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

;(setq make-backup-files nil
;      create-lockfiles nil)
;(setq version-control t)
;(setq kept-new-versions 6)
;(setq kept-old-version 2)
;(setq delete-old-versions t)
;(setq dired-kept-versions 1)
;; version control (if no git)

(add-hook 'dired-load-hook
          (function (lambda ()
                      (load "dired-x"))))
(setq dired-recursive-copies 'top
      dired-recursive-deletes 'top
      dired-use-ls-dired nil)

(set-face-attribute 'default nil
                    :background (if (display-graphic-p) "#222" "black");unspecified-gb
                    :foreground (if (display-graphic-p) "wheat" "white")
		    :family "juliamono"
		    :height 130)

(defun to-unifont()
  (interactive)
  (buffer-face-set '(:family "Unifont" :height 160)))
(global-set-key (kbd"C-c u")
                'to-unifont)

(setq custom-file (expand-file-name "custom.el"
                                    (concat user-emacs-directory "lisp/")))
(when (file-exists-p custom-file)
 (load-file custom-file))

;;;;;;;;
;; magit
;;;;;;;;
(ensure-installed 'magit)
;(require 'magit)
(autoload 'magit-status "magit" "Magit status." t)
(autoload 'magit-blame "magit" "Blame current file." t)
(autoload 'magit-log-buffer-file "magit" "Log current file." t)
(autoload 'magit-dispatch "magit" "Magit dispatch." t)
(autoload 'magit-file-dispatch "magit" "Magit file dispatch." t)
(global-set-key (kbd "C-x g") 'magit-status)
(with-eval-after-load 'magit
  (setq magit-auto-select-connection 'always)
  ;; other configs
  )

(provide 'init-enhance)
