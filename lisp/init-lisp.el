;;;;;;;;;
;; Scheme 
;;;;;;;;;

(require 'cmuscheme)

(setq scheme-program-name
      (cond
       ((executable-find "scheme"))
       ((executable-find "racket"))
       ((executable-find "guile"))
       (t "scheme")))

;(add-to-list 'auto-mode-alist '("\\.scm\\'" . scheme-mode))
;(add-to-list 'auto-mode-alist '("\\.rkt\\'" . scheme-mode))
;(add-to-list 'auto-mode-alist '("\\.ss\\'" . scheme-mode))

(defun use-racket()
  (interactive)
  (setq scheme-program-name (excutable-find "racket"))
  (message "to racket"))

(defun use-chez()
  (interactive)
  (setq scheme-program-name (excutable-find "scheme"))
  (message "to chez"))

(defun use-guile()
  (interactive)
  (setq scheme-program-name (executable-find "guile"))
  (message "to guile"))

;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))

(defun switch-other-window-to-buffer (name)
    (other-window 1)
    (switch-to-buffer name)
    (other-window 1))

(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (split-window-vertically (floor (* 0.68 (window-height))))
    ;; (split-window-horizontally (floor (* 0.5 (window-width))))
    (switch-other-window-to-buffer "*scheme*"))
   ((not (member "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))))
    (switch-other-window-to-buffer "*scheme*"))))

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
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "C-c C-s")
                'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "C-c C-d")
                'scheme-send-definition-split-window)
    (local-set-key (kbd "C-c c") 'use-chez)
    (local-set-key (kbd "C-c r") 'use-racket)
    (local-set-key (kbd "C-c g") 'use-guile)))

;;;;;;;;;;;;;;
;; common lisp
;;;;;;;;;;;;;;

(remove-hook 'lisp-mode-hook 'cl-lisp-mode-hook)

(ensure-installed 'sly)
;(require 'sly)
(autoload 'sly "sly" "Start SLY" t)
(autoload 'sly-mode "sly" "SLY mode" t)

(setq sly-auto-select-connection 'always)
;(setq sly-kill-without-query-p t)
(setq sly-description-autofocus t) 
(setq sly-inhibit-pipelining nil)
(setq sly-load-failed-fasl 'always)

;; XXX: Work around a bug in SLY whereby installing/compiling it as
;; above fails to correctly set version (not very problematic for
;; Portacle, which always ensures matching versions anyway)
(setq sly-ignore-protocol-mismatches t)

;; Make sure SLY knows about our SBCL
(setq sly-lisp-implementations
      `((sbcl (,(executable-find "sbcl") "--dynamic-space-size" "256"))))

;; Don't turn on paredit in REPL, but at least use electric-pair-mode
(add-hook 'sly-mrepl-mode-hook 'electric-pair-local-mode)

;; Make sure we don't clash with SLIME when starting
;;(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
;;(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
(add-hook 'lisp-mode-hook 'sly-mode)

(provide 'init-lisp)
