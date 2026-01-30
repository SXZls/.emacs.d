(setq visible-bell t)
(setq inhibit-startup-screen t)
(global-font-lock-mode 1)
(electric-pair-mode t)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'visual)
(column-number-mode 1)

(which-key-mode 1)

(ido-mode 1)

(set-background-color "black")
(set-foreground-color "white")

(setq custom-file (expand-file-name "custom.el" (concat user-emacs-directory "lisp/")))
(when(file-exists-p custom-file)
 (load-file custom-file))

(provide 'init-cust)
