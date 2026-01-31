(require 'package)

(add-to-list 'package-archives '("melpa"  . "https://melpa.org/packages/")t)

(package-initialize) ;; You might already have this line

(require 'use-package-ensure)

(unless package-archive-contents
   (package-refresh-contents))

(provide 'init-package)
