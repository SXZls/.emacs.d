;; -*-lexical-binding: t; -*-
(defvar file-name-handler-alist--orig file-name-handler-alist)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      jit-lock-defer-time 0.05)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (* 16 1024 1024)
		  gc-cons-percentage 0.1
                  file-name-handler-alist file-name-handler-alist--orig)))

(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))

;; Recursively add subdirectories in `site-lisp` to `load-path`.
;; Avoid placing large files like EAF in `site-lisp` to prevent slow startup.
(let ((default-directory
       (expand-file-name "site-lisp" user-emacs-directory)))
  (normal-top-level-add-subdirs-to-load-path))
;;;;;;;;;;
;; package
(setq package-archives
             '(("melpa" . "https://melpa.org/packages/")
               ("nongnu" . "https://elpa.nongnu.org/packages/")
               ("gnu" . "https://elpa.gnu.org/packages/")))

(defvar package-contents-refreshed nil)

(defun package-ensure-refreshed ()
  (unless package-contents-refreshed
    (package-refresh-contents)
    (setq package-contents-refreshed t)))

(defun package-locally-installed-p (package)
  (or (assq package package-alist)
      (package-built-in-p package)))

(defun ensure-installed (&rest packages)
  (when-let ((missing (cl-remove-if
                       #'package-locally-installed-p packages)))
    (package-ensure-refreshed)
    (mapc #'package-install missing)))

(ensure-installed 'magit 'paredit 'yasnippet 'sly)
;;;;;;;;;;
;; enhance
(setq-default indent-tabs-mode nil)
(recentf-mode 1)
(save-place-mode 1)
(electric-pair-mode 1)
;(global-display-line-numbers-mode 1)
(column-number-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(ido-mode 1)
(prefer-coding-system 'utf-8)
(auto-image-file-mode 1)
(setq uniquify-buffer-name-style 'forward
      visible-bell 1
      enable-recursive-minibuffers 1
      treesit-extra-load-path (executable-find "tree-sitter")
      isearch-allow-scroll 1
      redisplay-skip-fontification-on-input 1
      save-interprogram-paste-before-kill 1
      kill-do-not-save-duplicates 1
      inhibit-startup-screen 1
      initial-major-mode 'fundamental-mode
      frame-inhibit-implied-resize 1
      auto-mode-case-fold nil
      buffer-face-mode-face '(:family "Unifont" :height 160))

(set-face-attribute 'default nil
                    :background (if (display-graphic-p)
                                    "#022" "unspecified-bg")
                    :foreground (if (display-graphic-p)
                                    "wheat" "unspecified-fg")
		    :family "juliamono"
                    :height 120)

(setq custom-file (expand-file-name "custom.el"
                                    (concat user-emacs-directory
                                            "site-lisp/")))
(when (file-exists-p custom-file)
  (load-file custom-file))

(dolist (pair '(("\\.l\\'" . c-mode)
           ("\\.cl\\'" . lisp-mode)
           ("\\.lisp\\'" . lisp-mode)
           ("\\.scm\\'" . scheme-mode)
           ("\\.rkt\\'" . scheme-mode)
           ("\\.ss\\'" . scheme-mode)))
  (add-to-list 'auto-mode-alist pair))
;; easy to add-mode-list.
;;;;;;;;;
;; abbrev
(setq my-abbrevs-file (expand-file-name
                       "site-lisp/abbrevs.el"
                       user-emacs-directory))
(when (file-exists-p my-abbrevs-file)
  (read-abbrev-file my-abbrevs-file))
;;;;;;;;;
;;; dired
(add-hook 'dired-load-hook
          (function (lambda ()
                      (load "dired-x"))))
(setq dired-recursive-copies 'top
      dired-recursive-deletes 'top)
;;;;;;;;
;; magit
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

;;;;;;;;;;;;
;; yasnippet
(autoload 'yas-minor-mode "yasnippet" "YASnippet minor mode." t)
(autoload 'yas-reload-all "yasnippet" nil t)
(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'LaTeX-mode-hook 'yas-minor-mode)

;;;;;;;;;;
;; paredit
(autoload 'enable-paredit-mode "paredit" "Paredit of Lisp code." t)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(put 'paredit-forward-delete 'delete-selection 'supersede)
(put 'paredit-backward-delete 'delete-selection 'supersede)
(put 'paredit-newline 'delete-selection t)

;;;;;;;;;
;; Scheme 
;(require 'cmuscheme)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process" t)
(autoload 'scheme-mode "cmuscheme" "Scheme mode" t)

(setq scheme-program-name
      (or (executable-find "scheme")
          (executable-find "racket")
          (executable-find "guile")
          "scheme"))

(defun use-scheme (program)
  (interactive
   (list (completing-read "Scheme inerpreter:"
                          '("scheme" "racket" "guile") nil t)))
  (if-let ((path (executable-find program)))
      (progn (setq scheme-program-name path))
    (user-error "Cannot find '%s' in PATH" program)))

(defun scheme-split-window ()
  (unless (get-buffer-window "*scheme*")
    (when (= 1 (count-windows))
      (split-window-vertically (floor (* 0.68 (window-height)))))
    (with-selected-window (next-window)
      (switch-to-buffer "*scheme*"))))
(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))
(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
          (lambda ()
            ;(paredit-mode 1)
            (define-key scheme-mode-map (kbd "C-c C-s")
                        'scheme-send-last-sexp-split-window)
            (define-key scheme-mode-map (kbd "C-c C-d")
                        'scheme-send-definition-split-window)
            (local-set-key (kbd "C-c C-p") 'use-scheme)))

;;;;;;;;;;;;;;
;; common lisp
(remove-hook 'lisp-mode-hook 'cl-lisp-mode-hook)
(autoload 'sly "sly" "Start SLY" t)
(autoload 'sly-mode "sly" "SLY mode" t)

(setq sly-auto-select-connection 'always
      ;sly-kill-without-query-p t
      sly-description-autofocus t 
      sly-inhibit-pipelining nil
      sly-load-failed-fasl 'always
      ;; Make sure SLY knows about our SBCL
      sly-lisp-implementations
      `((sbcl (,(executable-find "sbcl") "--dynamic-space-size" "256"))))
;; Don't turn on paredit in REPL, but at least use electric-pair-mode
(add-hook 'sly-mrepl-mode-hook 'electric-pair-local-mode)
;; Make sure we don't clash with SLIME when starting
(add-hook 'lisp-mode-hook 'sly-mode)

(provide 'init)
