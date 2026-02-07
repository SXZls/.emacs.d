(deftheme srq-custom)
  (custom-theme-set-faces
   'srq-custom
   `(default ((t
               (:background
                ,(if(display-graphic-p) "#002b36" "black")
                :foreground
                ,(if (display-graphic-p) "wheat" "white"))))))

(provide-theme 'srq-custom)
