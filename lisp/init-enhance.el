(setq visible-bell t)
(electric-pair-mode t)
;(global-display-line-numbers-mode t)
(column-number-mode 1)
(ido-mode 1)
(global-font-lock-mode t)
(transient-mark-mode t)
(prefer-coding-system 'utf-8)

(setq track-eol t)
(setq kill-whole-line t)

(setq-default indent-tabs-mode nil)
(setq tab-always-indent 'complete)

(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
      sentence-end-double-space nil)
;; Setting sentence-end can recognize Chinese punctuation.
;There is no need to insert two spaces when filling.

(setq recentf-exclude '("\\.[a-z]+\\.eld$"
                        "\\.emacs\\.d/\\(?:[a-z]\\|-\\)*$" "[0a-f]+\\.plstore$")
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

(require 'dired-x)
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

(set-face-attribute
 'default nil
 :background (if (display-graphic-p) "darkslategray" "black")
 :foreground (if (display-graphic-p) "wheat" "white"))

(setq custom-file (expand-file-name "custom.el"
                                    (concat user-emacs-directory "lisp/")))
(when(file-exists-p custom-file)
 (load-file custom-file))

(use-package magit
  :commands (magit-status magit-blame magit-log-buffer-file))

(require 'no-littering)

(provide 'init-enhance)
