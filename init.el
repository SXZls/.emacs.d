(when (member "Iosevka" (font-family-list))
  (set-face-attribute 'default nil
		      :family "iosevka"
		      :height 142))

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold 800000
		  gc-cons-percentage 0.1)))

(require 'cl-lib)
(defun add-subdirs-to-load-path (search-dir)
  (interactive)
  (let* ((dir (file-name-as-directory search-dir)))
    (dolist (subdir
             ;; Filter out unnecessary directories to improve Emacs startup speed
             (cl-remove-if
              #'(lambda (subdir)
                  (or
                   ;; Remove files that are not directories
                   (not (file-directory-p (concat dir subdir)))
                   ;; Remove parent, language-related, and version control directories
                   (member subdir '("." ".." 
                                    "dist" "node_modules" "__pycache__" 
                                    "RCS" "CVS" "rcs" "cvs" ".git" ".github" "el~" "EL~")))) 
              (directory-files dir)))
      (let ((subdir-path (concat dir (file-name-as-directory subdir))))
        ;; Only add paths with .el .so .dll files into `load-path` to improve Emacs startup speed
        (when (cl-some #'(lambda (subdir-file)
                           (and (file-regular-p (concat subdir-path subdir-file))
                                ;; .so .dll indicate dynamic libraries written in non-Elisp languages
                                (member (file-name-extension subdir-file) '("el" "so" "dll"))))
                       (directory-files subdir-path))

          ;; Note: The third parameter of `add-to-list` must be `t`, meaning adding to the end of the list
          ;; This ensures that Emacs searches for Elisp plugins in order from parent to child directories.
	  ;; Reversing the order may cause Emacs to fail to start properly.
          (add-to-list 'load-path subdir-path t))

        ;; Continue recursively searching subdirectories
        (add-subdirs-to-load-path subdir-path)))))

(add-subdirs-to-load-path (expand-file-name "~/.emacs.d/"))


(require 'init-cust)

(require 'init-package)

(require 'init-cl)

(require 'init-scm)

(provide 'init)
