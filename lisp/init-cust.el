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

(provide 'init-cust)
