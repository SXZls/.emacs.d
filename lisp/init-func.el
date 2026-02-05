(defun sams-apply-macro-on-region (start end command) ;[Jesper]
  "Evaluate a given function (or the last defined macro) on region.
I.e. it will continue until the point is position
outside the region.
This function is much like the function apply-macro-to-region-lines,
which is shipped with Emacs. It has one difference though. It
executes the macros until point is below the end of the region."
  (interactive "r\naCommand name (default:last keyboard macro).")
  (goto-char end)
  (let ((mark (point-marker)))
    (goto-char start)
    (while (< (point) (marker-position mark))
    (if (not (fboundp command))
        (call-last-kbd-macro)
      (command-execute command)))))

(provide 'init-func)
