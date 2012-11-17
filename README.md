# scalatra-mode - a minor-mode for emacs

This mode provides font-lock for editing scalatra routes. It
highlights the method and URL parameters in
font-lock-preprocessor-face.

## Setting the mode up for use

1. Install scala-mode2 from http://github.com/hvesalai/scala-mode2

2. Download the files to a local directory. You can use the *git clone*
command, this will create a new directory called scalatra-mode.
```
git clone git://github.com/hvesalai/scalatra-mode.git
```

3. Include the following in your `.emacs` file after scala-mode2. 

```lisp
(add-to-list 'load-path "/path/to/scalatra-mode/")

(require 'scalatra-mode)

(add-hook 'scala-mode-hook '(lambda ()
  (scalatra-mode)
))
```

## Credits

Mode development: Heikki Vesalainen
