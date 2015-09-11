#!/bin/sh
# tangle files with org-mode
#
DIR=`pwd`
#FILES=""
# wrap each argument in the code required to call tangle on it
#for i in $@; do
#    FILES="$FILES \"$i\""
#done
#emacs -Q --batch \
#    --eval "(progn
#            (add-to-list 'load-path (expand-file-name \"~/src/org/lisp/\"))
#            (add-to-list 'load-path (expand-file-name \"~/src/org/contrib/lisp/\" t))
#            (require 'org)(require 'org-exp)(require 'ob)(require 'ob-tangle)
#            (mapc (lambda (file)
#            (find-file (expand-file-name file \"$DIR\"))
#            (org-babel-tangle)
#            (kill-buffer)) '($FILES)))" 2>&1 |grep tangled

# emacs --batch --execute='(setq vc-follow-symlinks nil)' -- visit=current-day.org --execute='(org-export-as-html-and-open nil)'
FILE=$1
TYPE=$2
COMMAND="(org-latex-export-to-latex nil)"

if [ "$1" = "-h" ]; then
    echo "usage: batch-export-org.sh <org-file> [latex|html|pdf]"
    exit
fi

if [ -n $TYPE ]; then
if [ "$TYPE" = "pdf" ]; then
echo "processing pdf"
COMMAND="(org-latex-export-to-pdf nil)"
fi
if [ "$TYPE" = "html" ]; then
echo "processing html"
COMMAND="(org-html-export-to-html nil)"
fi
else
TYPE="latex"
echo "processing latex"
fi

#emacs --batch --eval "(load-file \"/home/jo/.emacs\")" --visit $1 --execute "$COMMAND"
# Note: we are loading the "main" .emacs configuration file.
emacs --batch --eval "(load-file (expand-file-name \"~/.emacs\"))" --visit $1 --execute "$COMMAND"


#emacs --batch --eval "(progn
#			(add-to-list 'load-path (expand-file-name \"/Emacs/site-lisp/\"))
#			(add-to-list 'load-path (expand-file-name \"~/Emacs/site-lisp/org/\"))
#			(add-to-list 'load-path (expand-file-name \"~/Emacs/site-lisp/ess\"))
#			(require 'ess-site)
#			(setq-default inferior-R-args \"--no-save\")
#			(setq ess-ask-for-ess-directory nil)
#			(require 'org-install)(require 'ob-tangle)(require 'ob-sh)(require 'ox-html)(require 'ox-latex)(require 'ox-bibtex)
#			(org-babel-do-load-languages 'org-babel-load-languages '((R . t)(latex . t)))
#			(setq org-latex-pdf-process (quote (\"latexmk -gg -f -cd -pdf %f\")))
#			(setq org-confirm-babel-evaluate nil)
#			)" --visit $1 --execute "$COMMAND"


