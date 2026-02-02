(setq visible-bell t)
(electric-pair-mode t)
;(setq display-line-numbers-type 'visual)
;(global-display-line-numbers-mode t)
(column-number-mode 1)

(which-key-mode 1)

(ido-mode 1)

(setq kill-ring-max 150)
;; with a big kill ring.
;This prevents me from accidentally cutting out important things.

(setq-default indent-tabs-mode nil)

(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;; Setting sentence-end can recognize Chinese punctuation.
;There is no need to insert two spaces when filling.

(setq enable-recursive-minibuffers t)

(setq scroll-margin 3
      scroll-conservatively 10000)

(setq frame-title-format "GNU Emacs@%b")

(auto-image-file-mode)
;;open picture

(put 'set-goal-column 'disabled nil)
; (put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

;(setq version-control t)
;(setq kept-new-versions 3)
;(setq delete-old-versions t)
;(setq dired-kept-versions 1)
;; version control (if no git)

(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

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

(use-package no-littering
  :ensure t)

(provide 'init-enhance)
