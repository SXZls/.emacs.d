;; -*- lexical-binding: t; -*-

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6

      frame-inhibit-implied-resize t
      inhibit-x-resources t
       
      package-enable-at-startup nil
      package--init-file-ensured t

      default-frame-alist
      '(;(vertical-scroll-bars . nil)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)))
