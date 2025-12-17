(setq
 native-comp-deferred-compilation nil
 native-comp-jit-compilation nil ;; Prevent unwanted runtime compilation for gccemacs (native-comp) users;
;; packages are compiled ahead-of-time when they are installed and site files
;; are compiled when gccemacs is installed.
 frame-inhibit-implied-resize t
 
 initial-major-mode 'fundamental-mode
 
 package-enable-at-startup nil
 package--init-file-ensured t
 use-package-enable-ime-menu-support t

 auto-mode-case-fold nil
 
 warning-suppress-types '((files))) ;; no lexical binding

(provide 'init-accelerate)
