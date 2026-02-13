(setq gc-cons-threshold most-positive-fixnum                                gc-cons-percentage 0.6)

(setq
 frame-inhibit-implied-resize t
 inhibit-x-resources t
 inhibit-startup-screen t
 initial-major-mode 'fundamental-mode
 
 package-enable-at-startup nil
 package--init-file-ensured t

 auto-mode-case-fold nil)

(setq default-frame-alist
      '((vertical-scroll-bars . nil)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)))
