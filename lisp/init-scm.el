;;;;;;;;;;;;
;; Scheme 
;;;;;;;;;;;;

(require 'cmuscheme)

(add-to-list 'auto-mode-alist '("\\.rkt\\'" . scheme-mode))

(defvar racket-path "/usr/local/bin/")
(defvar chez-path "/bin/")
(defvar guile-path "/bin/")

(defun use-racket()
  (interactive)
  (setq scheme-program-name "racket")
  (push racket-path exec-path)
  (message "to racket"))

(defun use-chez()
  (interactive)
  (setq scheme-program-name "scheme")
  (push chez-path exec-path)
  (message "to chez"))

(defun use-guile()
  (interactive)
  (setq scheme-program-name "guile")
  (push guile-path exec-path)
  (message "to guile"))

(use-chez)

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
    (define-key scheme-mode-map (kbd "!") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "@") 'scheme-send-definition-split-window)
    (local-set-key (kbd "C-c c") 'use-chez)
    (local-set-key (kbd "C-c r") 'use-racket)
    (local-set-key (kbd "C-c g") 'use-guile)))

(provide 'init-scm)
