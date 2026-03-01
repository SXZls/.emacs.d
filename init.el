(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold 800000
		  gc-cons-percentage 0.1
                  file-name-handler-alist (default-value 'file-name-handler-alist))))

(defun update-load-path (&rest _)
  "Update the `load-path` to prioritize personal configurations."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

;; Initialize load paths explicitly
(update-load-path)

;; Add subdirectories inside "site-lisp" to `load-path`
(defun add-subdirs-to-load-path (&rest _)
  "Recursively add subdirectories in `site-lisp` to `load-path`.

Avoid placing large files like EAF in `site-lisp` to prevent slow startup."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

;; Ensure these functions are called after `package-initialize`
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

(require 'cl-lib)

(require 'init-package)

(require 'init-utils)

(require 'init-enhance)

(require 'init-edit)

(require 'init-func)

(require 'init-cl)

(require 'init-scm)

(provide 'init)
