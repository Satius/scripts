(defgroup ebear nil
  "Convert makefile log to compile_commands.json"
  :prefix "ebear-"
  :group 'tools)

(defun ebear-is-compile-command (line)
  (string-match "q\\(\\+\\+\\|cc\\).*\s-c.*\s\\([^\s]+\.c\\(pp\\)?\\)\s" line)
  (match-string-no-properties 2 line))

(defun ebear-split-compile-command (line)
  (split-string line "[\s\"]+"))

(defun ebear-substitute-arg (arg)
  (cond ((equal arg "q++") "g++")
        ((equal arg "qcc") "gcc")
        (t arg)))

(defun ebear-format-args (args)
  (let ((result "\t\t\"arguments\": [\n"))
    (dolist (item args result)
      (setq result
            (concat result "\t\t\t\""
                    (ebear-substitute-arg item)
                    "\",\n")))
    (concat result "\t\t\t\"-Wall\",\n"
            "\t\t\t\"-pedantic\"\n\t\t],\n")))

(defun ebear-handle-file (line dir file)
  (concat "\t{\n"
          (format-args (ebear-split-compile-command line))
          "\t\t\"directory\": \"" dir "\",\n"
          "\t\t\"file\": \"" dir "/" file "\"\n"
          "\t},"))

(defun ebear-handle-commands (cmds dir)
  (concat "[\n"
          (dolist (line cmds)
            (let ((file (is-compile-command line)))
              (if file (insert (handle-file line dir file)))))
          "]\n"))

(provide 'ebear)
