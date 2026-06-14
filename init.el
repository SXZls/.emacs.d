;; -*-lexical-binding: t; -*-
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil
      jit-lock-defer-time 0
      )
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold 800000
		  gc-cons-percentage 0.1
                  file-name-handler-alist (default-value 'file-name-handler-alist))))

(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
;; Add subdirectories inside "site-lisp" to `load-path`
(defun add-subdirs-to-load-path (&rest _)
  "Recursively add subdirectories in `site-lisp` to `load-path`.
   Avoid placing large files like EAF in `site-lisp` to prevent slow startup."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

;; Ensure these functions are called after `package-initialize`
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

;;;;;;;;;;
;; package
(require 'package)

(add-to-list 'package-archives '("melpa"  . "https://melpa.org/packages/") t)

(package-initialize)

(defvar *package-lists-fetched* nil)

(defun soft-fetch-package-lists ()
  (unless *package-lists-fetched*
    (package-refresh-contents)
    (setf *package-lists-fetched* t)))

;; package-installed-p will always report NIL if a newer
;; version is available. We do not want that.
(defun package-locally-installed-p (package)
  (assq package package-alist))

(defun ensure-installed (&rest packages)
  (unless (cl-loop for package in packages
                   always (package-locally-installed-p package))
    (soft-fetch-package-lists)
    (dolist (package packages)
      (unless (package-locally-installed-p package)
        (package-install package)))))
;;;;;;;;;;
;; enhance
(setq-default indent-tabs-mode nil)

(recentf-mode 1) ;; recentf file
(save-place-mode 1)
(electric-pair-mode 1)
;(global-display-line-numbers-mode t)
(column-number-mode 1)
(ido-mode 1)
(prefer-coding-system 'utf-8)
(auto-image-file-mode 1)

(setq uniquify-buffer-name-style 'forward
      tab-always-indent 'complete
      visible-bell 1
      track-eol 1
      kill-whole-line 1
      enable-recursive-minibuffers t
      treesit-extra-load-path (executable-find "tree-sitter")
      isearch-allow-scroll t
      redisplay-skip-fontification-on-input t
      save-interprogram-paste-before-kill t
      kill-do-not-save-duplicates t
      )

(set-face-attribute 'default nil
                    :background (if (display-graphic-p)
                                    "grey10" "unspecified-bg")
                    :foreground (if (display-graphic-p)
                                    "wheat" "unspecified-fg")
		    :family "juliamono"
		    :height 130)

(defun to-unifont()
  (interactive)
  (buffer-face-set '(:family "Unifont" :height 160)))
(global-set-key (kbd"C-c u")
                'to-unifont)

(setq custom-file (expand-file-name "custom.el"
                                    (concat user-emacs-directory "site-lisp/")))
(when (file-exists-p custom-file)
  (load-file custom-file))

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
;;;;;;;;;
;; abbrev
(setq my-abbrevs-file (expand-file-name
                       "site-lisp/abbrevs.el"
                       user-emacs-directory))
(if (file-exists-p my-abbrevs-file)
    (read-abbrev-file my-abbrevs-file))
(global-set-key (kbd "M-/") 'dabbrev-expand)
;;;;;;;;;
;;; dired
(add-hook 'dired-load-hook
          (function (lambda ()
                      (load "dired-x"))))
(setq dired-recursive-copies 'top
      dired-recursive-deletes 'top
      dired-use-ls-dired nil)

;;;;;;;;
;; magit
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

;;;;;;;;;;;;
;; yasnippet
(ensure-installed 'yasnippet)
;(require 'yasnippet)
;(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(autoload 'yas-minor-mode "yasnippet" "YASnippet minor mode." t)
(autoload 'yas-reload-all "yasnippet" nil t)
(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'Latex-mode-hook 'yas-minor-mode)

;;;;;;;;;;
;; paredit
(ensure-installed 'paredit)
;(require 'paredit)
;(add-to-list 'load-path "~/.emacs.d/site-lisp/")

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
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

(ensure-installed 'sly)
;(require 'sly)
(autoload 'sly "sly" "Start SLY" t)
(autoload 'sly-mode "sly" "SLY mode" t)

(setq sly-auto-select-connection 'always
      ;sly-kill-without-query-p t
      sly-description-autofocus t 
      sly-inhibit-pipelining nil
      sly-load-failed-fasl 'always
      ;; XXX: Work around a bug in SLY whereby installing/compiling it as
      ;; above fails to correctly set version (not very problematic for
      ;; Portacle, which always ensures matching versions anyway)
      sly-ignore-protocol-mismatches t

      ;; Make sure SLY knows about our SBCL
      sly-lisp-implementations
      `((sbcl (,(executable-find "sbcl") "--dynamic-space-size" "256"))))
;; Don't turn on paredit in REPL, but at least use electric-pair-mode
(add-hook 'sly-mrepl-mode-hook 'electric-pair-local-mode)
;; Make sure we don't clash with SLIME when starting
(add-hook 'lisp-mode-hook 'sly-mode)

(provide 'init)
