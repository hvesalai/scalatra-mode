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
```

## Turning the mode on for a file

There are many ways you can turn the mode on for a file. One way is to
turn it on for all scala files. Just add the following to your
`.emacs` file:

```lisp
(add-hook 'scala-mode-hook '(lambda ()
  (scalatra-mode)
))
```

An other way is to use an emacs [*file
variable*](www.gnu.org/software/emacs/manual/html_node/emacs/Specifying-File-Variables.html). 
Include the following as the **first line** of your .scala file:

```
// -*- eval: (scalatra-mode) -*-
```

You can also use the longer format of the file variable, which you are
free to place anywhere in the file (e.g. at the end):

```
// Local Variables:
// eval: (scalatra-mode)
// End:
```

Lastly you can start the mode manually for any buffer. Just use
**M-x** *scalatra-mode* to start or stop the mode for a buffer.

## Credits

Mode development: Heikki Vesalainen
