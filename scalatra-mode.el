;;; scalatra-mode.el - a minor mode for editing scalatra routes
;;; Copyright (c) 2012 Heikki Vesalainen
;;; For information on the License, see the LICENSE file

(provide 'scalatra-mode)

(require 'scala-mode2)
(require 'scala-mode2-syntax)

(defconst scalatra-mode:route-start-re
  (concat "^\\s *\\("
          (regexp-opt '("get" "post" "delete" "put") 'words)
          "\\)(\"")
  "A particularly picky regular expression for matching scalatra
routes. Only works if the keyword is first on the line and is
followed by the symbols '(\"' without any interleaving
whitespace.")

(defconst scalatra-mode:url-param-re
  (concat ":[^:/)\"]*" )
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
    (backward-char)
    (or (and (save-excursion (goto-char (match-beginning 0))
                             (scala-syntax:skip-backward-ignorable)
                             (or
                              (/= 0 (skip-chars-backward "{)};"))
                              (scala-syntax:looking-back-empty-line-p)))
             (looking-at-p scala-syntax:oneLineStringLiteral-re)
             (save-excursion (backward-char)
                             (forward-list)
                             (scala-syntax:skip-forward-ignorable)
                             (looking-at-p "[{(]")))
        (scalatra-mode:mark-route-method limit))))

(defun scalatra-mode:limit-route-path ()
  "Expects the position to be just before the URL matching
string."
  (when (looking-at-p scala-syntax:oneLineStringLiteral-re)
    (match-end 0)))

(defconst scalatra-mode:font-lock-keywords
  (list (list
         'scalatra-mode:mark-route-method
         '(1 font-lock-preprocessor-face)
         (list
          scalatra-mode:url-param-re
          (scalatra-mode:limit-route-path) nil
          '(0 font-lock-preprocessor-face prepend nil)))))

(defun scalatra-mode:turn-on ()
  (font-lock-add-keywords nil
                          scalatra-mode:font-lock-keywords))

(defun scalatra-mode:turn-off ()
  (font-lock-remove-keywords nil
                             scalatra-mode:font-lock-keywords))
