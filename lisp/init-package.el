(require 'package)

(add-to-list 'package-archives '("melpa"  . "https://melpa.org/packages/") t)

(package-initialize)

(defun srq/require (packages)
  (dolist (package packages)
    (when (not (package-installed-p package))
      (package-refresh-contents)
      (package-install package))))

(require 'use-package)

(provide 'init-package)
