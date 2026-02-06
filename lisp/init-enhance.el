(require 'recentf)
(recentf-mode 1)
(require 'saveplace)
(setq-default save-place 1)
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
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

(setq recentf-exclude '("\\.[a-z]+\\.eld$"
                        "\\.emacs\\.d/\\(?:[a-z]\\|-\\)*$")
      dired-use-ls-dired nil)

(setq enable-recursive-minibuffers t)

(setq scroll-margin 3
      scroll-conservatively 97
      scroll-preserve-screen-position t)

(auto-image-file-mode)
;;open picture

(put 'set-goal-column 'disabled nil)
; (put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

;(setq make-backup-files nil
;      create-lockfiles nil)
;(setq version-control t)
;(setq kept-new-versions 3)
;(setq delete-old-versions t)
;(setq dired-kept-versions 1)
;; version control (if no git)

(add-hook 'dired-load-hook
          (function (lambda ()
                      (load "dired-x"))))
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

(when (member "JuliaMono" (font-family-list))
  (set-face-attribute 'default nil
		      :family "juliamono"
		      :height 142))
(defun to-unifont()
  (interactive)
  (buffer-face-set '(:family "Unifont" :height 160)))
(global-set-key (kbd"C-c u")
                'to-unifont)

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes" user-emacs-directory))
(load-theme 'srq-custom t)

(setq custom-file (expand-file-name "custom.el"
                                    (concat user-emacs-directory "lisp/")))
(when(file-exists-p custom-file)
 (load-file custom-file))

(use-package magit
  :commands (magit-status magit-blame magit-log-buffer-file))

(use-package no-littering)

(provide 'init-enhance)
