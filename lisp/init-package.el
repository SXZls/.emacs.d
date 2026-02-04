(require 'package)

(add-to-list 'package-archives '("melpa"  . "https://melpa.org/packages/") t)

(package-initialize)

(defun pkg/require (packages)
  (dolist (package packages)
    (when (not (package-install-papackage))
      (package-install package))))

(provide 'init-package)
