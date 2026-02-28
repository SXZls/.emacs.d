;;;;;;;;;;;;;;;;
;; common lisp
;;;;;;;;;;;;;;;;

(remove-hook 'lisp-mode-hook 'cl-lisp-mode-hook)

(ensure-installed 'sly)
(require 'sly)

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
      `((sbcl (,(env-bin-path "sbcl") "--dynamic-space-size" "256"))))

;; Don't turn on paredit in REPL, but at least use electric-pair-mode
(add-hook 'sly-mrepl-mode-hook 'electric-pair-local-mode)

;; Make sure we don't clash with SLIME when starting

;;(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
;;(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

(provide 'init-cl)
