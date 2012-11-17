;;; scalatra-mode.el - a minor mode for editing scalatra routes
;;; Copyright (c) 2012 Heikki Vesalainen
;;; For information on the License, see the LICENSE file

(provide 'scalatra-mode)

(require 'scala-mode)
(require 'scala-mode-syntax)

(defconst scalatra-mode:route-start-re
  (concat "\\(" 
          (regexp-opt '("get" "post" "delete" "put") 'words)
          "\\)(\"")
  "A particularly picky regular expression for matching scalatra
routes. Only works if the keyword is followed by the symbols
'(\"' without any interleaving whitespace.")

(defconst scalatra-mode:url-param-re
  (concat ":" scala-syntax:varid-re)
  "A regular expression that should match a parameter in a URL
matching string.")

(define-minor-mode scalatra-mode
  "Minor mode for editing scalatra files. It provides highlight
for scalatra routes"
  :lighter ":tra"
  :init-value nil
  :global nil
  :group 'scala
  (if scalatra-mode
      (scalatra-mode:turn-on)
    (scalatra-mode:turn-off)))

(defun scalatra-mode:mark-route-method (&optional limit)
  "Search for a valid route, return t if one is found, else
nil. Match data group 1 is the method name. Position will be
just before the URL matching string."
  (when (re-search-forward scalatra-mode:route-start-re limit t)
    (goto-char (- (match-end 0) 1))
    (if (looking-at-p scala-syntax:oneLineStringLiteral-re)
        t
      (scalatra-mode:mark-route-method limit))))

(defun scalatra-mode:limit-route-path ()
  "Expects the position to be just before the URL matching
string."
  (when (looking-at-p scala-syntax:oneLineStringLiteral-re)
    (message "limit at %d" (match-end 0))
    (match-end 0)))

(defconst scalatra-mode:font-lock-keywords
  (list (list 
         'scalatra-mode:mark-route-method 
         '(1 font-lock-constant-face)
         (list 
          scalatra-mode:url-param-re
          (scalatra-mode:limit-route-path) nil
          '(0 font-lock-constant-face prepend nil)))))

(message "%s" scalatra-mode:font-lock-keywords)

(defun scalatra-mode:turn-on ()
  (message "scalatra-mode on")
  (font-lock-add-keywords nil
                          scalatra-mode:font-lock-keywords))

(defun scalatra-mode:turn-off ()
  (message "scalatra-mode off")
  (font-lock-remove-keywords nil
                             scalatra-mode:font-lock-keywords))
