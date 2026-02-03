(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(setq
 native-comp-deferred-compilation nil
 native-comp-jit-compilation nil
 ;; Prevent unwanted runtime compilation for gccemacs (native-comp) users;
 ;; packages are compiled ahead-of-time when they are installed and site files
 ;; are compiled when gccemacs is installed.
 frame-inhibit-implied-resize t
 inhibit-x-resources t
 inhibit-startup-screen t
 frame-title-format "^x.%b"

 initial-major-mode 'fundamental-mode
 
 package-enable-at-startup nil
 package-quickstart nil
 package--init-file-ensured t
 use-package-enable-ime-menu-support t

 auto-mode-case-fold nil
 
 warning-suppress-types '((files))) ;; no lexical binding

(prefer-coding-system 'utf-8)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
