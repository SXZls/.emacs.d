(deftheme srq-custom)
  (custom-theme-set-faces
   'srq-custom
   `(default ((t
               (:background
                ,(if(display-graphic-p) "darkslategray" "black")
                :foreground
                ,(if (display-graphic-p) "wheat" "white"))))))

(provide-theme 'srq-custom)
