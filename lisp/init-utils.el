(cl-defmacro os-case (&body cases)
  `(cond ,@(cl-loop for case in cases collect
                    (if (eql (car case) t)
                        `(t ,@(cdr case))
                      `((eql system-type ',(car case)) ,@(cdr case))))))

(setq env-root (replace-regexp-in-string "\\\\" "/" (or (getenv "ROOT") (expand-file-name "~/"))))
(setq env-os (os-case (gnu/linux "lin") (darwin "mac") (windows-nt "win")))

(defun env-path (path)
  (concat env-root path))

(defun env-os-path (path)
  (env-path (concat env-os "/" path)))

(defun env-bin-path (bin)
  (env-os-path (os-case (windows-nt (concat "bin/" bin ".exe"))
                             (t (concat "bin/" bin)))))

(defun env-app-path (app path)
  (env-os-path (concat app "/" path)))

(defun add-to-path (&rest things)
  (cond ((eql system-type 'windows-nt)
         (setenv "PATH" (concat (mapconcat (lambda (a) (replace-regexp-in-string "/" "\\\\" a)) things ";")
                                ";" (getenv "PATH"))))
        (t
         (setenv "PATH" (concat (mapconcat 'identity things ":")
                                ":" (getenv "PATH")))))
  (setq exec-path (append exec-path things)))

;;; Toolkit functions
(defun env-fwrite (contents file &optional append)
  (write-region contents nil file append))

(defun env-fread (file)
  (with-temp-buffer
      (insert-file-contents file)
    (buffer-string)))

;(defvar dumped-load-path)
;(defvar dumped-eln-path)
;(if (not (boundp 'dumped-load-path))
;    (progn
;      (setq dumped-load-path (list "~/.emacs.d/elpa"))
;      (setq dumped-eln-path (list "~/.emacs.d/eln-cache"))
;      (load (concat (or (expand-file-name "~/.emacs.d/lisp/init-enhance")
;      (expand-file-name "~/.emacs.dlisp/edit"))))))
;  (setq load-path dumped-load-path)
;  (when (native-comp-available-p)
;   (setq native-comp-jit-compilation t
;         native-comp-eln-load-path dumped-eln-path))
;; native complition config

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

(provide 'init-utils)
