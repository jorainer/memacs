
;;; ox-ravel.el --- Sweave/knit/brew document maker for orgmode
;; Copyright (C) 2012  Charles C. Berry

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary: 
;;              See ravel.org for details.
;;
;;; Code:
;;

(require 'ox-latex)
(require 'ox-html)
(require 'ox-beamer)
(require 'ox-md)

(org-export-define-derived-backend 'latex-noweb 'latex
  :translate-alist '((src-block . org-ravel-src-block)
                    (inline-src-block . org-ravel-inline-src-block))
  :menu-entry
  '(?l 1
      ((?r "As Rnw File" org-ravel-latex-noweb-dispatch))))

(defun org-ravel-chunk-style-latex-noweb 
  (label ravel r-headers-attr src-code)
  "Chunk style for noweb style.
LABEL is the chunk name, RAVEL is the collection of ravel args as
a string, R-HEADERS-ATTR is the collection of headers from Babel
as a string parseable by `org-babel-parse-header-arguments',
SRC-CODE is the code from the block."
  (concat
   "<<" label
   (if (and ravel label) ",") ravel ">>=\n"
   src-code
   "@ %def\n"))

(defun org-ravel-inline-style-latex-noweb 
  (inline-src-block contents info)
  "Traditional Sweave style Sexpr using the INLINE-SRC-BLOCK element.
CONTENTS holds the contents of the item.  INFO is a
plist holding contextual information."
  (format "\\Sexpr{ %s }" (org-element-property :value inline-src-block)))

(defun org-ravel-latex-noweb-dispatch 
  (&optional async subtreep visible-only body-only ext-plist)
"Execute menu selection. See org-export.el for meaning of ASYNC,
      SUBTREEP, VISIBLE-ONLY and BODY-ONLY."
(interactive)
(if async
    (message "No async allowed.")
  (let
      ((outfile  (org-export-output-file-name ".Rnw" subtreep)))
       (org-export-to-file 'latex-noweb 
                           outfile async subtreep visible-only 
                           body-only ext-plist))))

(unless 
    (assoc "minimalRnw" org-latex-classes)
  (let    
      ((art-class (assoc "article" org-latex-classes))
       (headstring "\\documentclass{article}\n[NO-DEFAULT-PACKAGES]\n\\usepackage{hyperref}"))
    (add-to-list 'org-latex-classes
                 (append 
                  (list "minimalRnw"
                        headstring)
                  (cddr 
                   (assoc "article" 
                          org-latex-classes))))))

(org-export-define-derived-backend 'beamer-noweb 'beamer
  :translate-alist '((src-block . org-ravel-src-block)
                    (inline-src-block . org-ravel-inline-src-block))
  :menu-entry
  '(?l 1
      ((?s "As Rnw Beamer" org-ravel-beamer-noweb-dispatch))))

(defun org-ravel-chunk-style-beamer-noweb
   (label ravel r-headers-attr src-code)
   "Chunk style for noweb style.
 LABEL is the chunk name, RAVEL is the collection of ravel args as
 a string, R-HEADERS-ATTR is the collection of headers from Babel
 as a string parseable by `org-babel-parse-header-arguments',
 SRC-CODE is the code from the block."
   (concat
    "%\n<<" label
    (if (and ravel label) ",") ravel ">>=\n"
    src-code
    "@ %def\n"))

(defalias 'org-ravel-inline-style-beamer-noweb 'org-ravel-inline-style-latex-noweb)

(defun org-ravel-beamer-noweb-dispatch 
  (&optional async subtreep visible-only body-only ext-plist)
"Execute menu selection. See org-export.el for meaning of ASYNC,
      SUBTREEP, VISIBLE-ONLY and BODY-ONLY."
(interactive)
(if async
    (message "No async allowed.")
  (let
      ((outfile  (org-export-output-file-name ".Rnw" subtreep)))
       (org-export-to-file 'beamer-noweb 
                           outfile async subtreep visible-only 
                           body-only ext-plist))))

(unless
    (assoc "beamer" org-latex-classes)
  (add-to-list 
   'org-latex-classes  
   (append (list
            "beamer"
            "\\documentclass[11pt]{beamer}")
           (cddr (assoc "article" org-latex-classes)))))

(org-export-define-derived-backend 'latex-brew 'latex
   :translate-alist '((src-block . org-ravel-src-block)
                     (inline-src-block . org-ravel-inline-src-block))
   :menu-entry
   '(?l 2
      ((?w "As Brew File" org-ravel-latex-brew-dispatch))))

(defun org-ravel-chunk-style-latex-brew 
  (label ravel r-headers-attr src-code)
  "Default chunk style for brew style.
LABEL is the chunk name,RAVEL is the collection of ravel args as a
string,R-HEADERS-ATTR is the collection of headers from Babel as
a string parseable by `org-babel-parse-header-arguments',SRC-CODE
is the code from the block."
    (format (org-ravel-format-brew-spec ravel) src-code))

(defun org-ravel-inline-style-latex-brew 
  (inline-src-block contents info)
  "Traditional brew style using the INLINE-SRC-BLOCK element.
CONTENTS holds the contents of the item.  INFO is a plist holding
contextual information."
  (format (org-ravel-format-brew-spec
           (or
            (org-element-property :parameters inline-src-block)
            "<%= code -%>"))
          (org-element-property :value inline-src-block)))

(defun org-ravel-format-brew-spec (&optional spec)
  "Check a brew SPEC, escape % signs, and add a %s spec."
  (let
      ((spec (or spec "<% %>")))
    (if (string-match 
         "<\\(%+\\)\\([=]?\\)\\(.+?\\)\\([{}]?[ ]*-?\\)\\(%+\\)>" 
         spec)
        (let (
              (opct (match-string 1 spec))
              (eqsign (match-string 2 spec))
              (filler (match-string 3 spec))
              (enddash (match-string 4 spec))
              (clpct (match-string 5 spec)))
          (if (string= opct clpct)
              (concat "<" opct opct eqsign " %s " enddash clpct clpct ">")
            (error "Percent signs do not balance:%s" spec)))
      (error "Invalid spec:%s" spec))))

(defun org-ravel-latex-brew-dispatch 
  (&optional async subtreep visible-only body-only ext-plist)
"Execute menu selection. See org-export.el for meaning of ASYNC,
      SUBTREEP, VISIBLE-ONLY and BODY-ONLY."
(interactive)
(if async
    (message "No async allowed.")
  (let
      ((outfile  (org-export-output-file-name ".brew" subtreep)))
       (org-export-to-file 'latex-brew 
                           outfile async subtreep visible-only 
                           body-only ext-plist))))

(org-export-define-derived-backend 'html-knitr 'html
  :translate-alist '((src-block . org-ravel-src-block)
                    (inline-src-block . org-ravel-inline-src-block))
   :menu-entry
   '(?h 3
      ((?r "As Rhtml File" org-ravel-html-knitr-dispatch))))

(defun org-ravel-chunk-style-html-knitr 
  (label ravel r-headers-attr src-code)
  "Chunk style for noweb style.
LABEL is the chunk name, RAVEL is the collection of ravel args as
a string, R-HEADERS-ATTR is the collection of headers from Babel
as a string parseable by `org-babel-parse-header-arguments',
SRC-CODE is the code from the block."
  (concat
   "<!--begin.rcode "
   label
   (if (and ravel label) ", ") ravel "\n"
   src-code
   "end.rcode-->\n"))

(defun org-ravel-inline-style-html-knitr 
  (inline-src-block contents info)
  "Traditional Sweave style Sexpr using the INLINE-SRC-BLOCK element.
CONTENTS holds the contents of the item.  INFO is a
plist holding contextual information."
  (format "<!--rinline %s -->" (org-element-property :value inline-src-block)))

(defun org-ravel-html-knitr-dispatch 
  (&optional async subtreep visible-only body-only ext-plist)
"Execute menu selection. See org-export.el for meaning of ASYNC,
      SUBTREEP, VISIBLE-ONLY and BODY-ONLY."
(interactive)
(if async
    (message "No async allowed.")
  (let
      ((outfile  (org-export-output-file-name ".Rhtml" subtreep)))
       (org-export-to-file 'html-knitr 
                           outfile async subtreep visible-only 
                           body-only ext-plist))))

(org-export-define-derived-backend 'md-knitr 'md
  :translate-alist '((src-block . org-ravel-src-block)
                    (inline-src-block . org-ravel-inline-src-block))
  :menu-entry
  '(?m 4
      ((?r "As Rmd (Markdown) File" org-ravel-md-knitr-dispatch))))

(defun org-ravel-chunk-style-md-knitr 
  (label ravel r-headers-attr src-code)
  "Chunk style for markdown.
LABEL is the chunk name, RAVEL is the collection of ravel args as
a string, R-HEADERS-ATTR is the collection of headers from Babel
as a string parseable by `org-babel-parse-header-arguments',
SRC-CODE is the code from the block."
  (concat
   "```{r "
   label
   (if (and ravel label) ", ") ravel "}\n"
   src-code
   "```\n"))

(defun org-ravel-inline-style-md-knitr 
  (inline-src-block contents info)
  "Markdown style Sexpr using the INLINE-SRC-BLOCK element.
CONTENTS holds the contents of the item.  INFO is a
plist holding contextual information."
  (format "`r %s`" (org-element-property :value inline-src-block)))

(defun org-ravel-md-knitr-dispatch 
  (&optional async subtreep visible-only body-only ext-plist)
"Execute menu selection. See org-export.el for meaning of ASYNC,
      SUBTREEP, VISIBLE-ONLY and BODY-ONLY."
(interactive)
(if async
    (message "No async allowed.")
  (let
      ((outfile  (org-export-output-file-name ".Rmd" subtreep)))
       (org-export-to-file 'md-knitr 
                           outfile async subtreep visible-only 
                           body-only ext-plist))))

(org-export-define-derived-backend 'md-brew 'md
  :translate-alist '((src-block . org-ravel-src-block)
                    (inline-src-block . org-ravel-inline-src-block))
  :menu-entry
  '(?m 4
      ((?w "As brew (Markdown) File" org-ravel-md-brew-dispatch))))

(defalias 'org-ravel-chunk-style-md-brew  
  'org-ravel-chunk-style-latex-brew)

(defalias 'org-ravel-inline-style-md-brew  
  'org-ravel-inline-style-latex-brew)

(defun org-ravel-md-brew-dispatch 
  (&optional async subtreep visible-only body-only ext-plist)
"Execute menu selection. See org-export.el for meaning of ASYNC,
      SUBTREEP, VISIBLE-ONLY and BODY-ONLY."
(interactive)
(if async
    (message "No async allowed.")
  (let
      ((outfile  (org-export-output-file-name ".brew" subtreep)))
       (org-export-to-file 'md-brew 
                           outfile async subtreep visible-only 
                           body-only ext-plist))))

(defun org-ravel-get-ancestor-fun (funkey &optional info)
"Ancestral definition of function.
Find  second or sole FUNKEY function in the `:translate-alist' property of INFO."
(let* ((tr-list (plist-get  info :translate-alist))
       (newfun-pair (assoc funkey tr-list))
       (new-and-rest (memq newfun-pair tr-list)))
  (or
   (cdr (assoc funkey (cdr new-and-rest)))
   (cdr newfun-pair))))

(defun org-ravel-src-block (src-block contents info)
      "Transcode a SRC-BLOCK element.
CONTENTS holds the contents of the item.  INFO is a plist
holding contextual information.  If org-ravel-chunk-style-BACKEND
is defined, that will be called for R src blocks."
      (let* ((lang (org-element-property :language src-block))
             (label (org-element-property :name src-block))
             (ravel-attr (org-element-property :attr_ravel src-block))
             (r-headers-attr (org-element-property :attr_r-headers src-block))
             (ravel (if ravel-attr
                        (mapconcat #'identity ravel-attr ", ")))
             (bkend (org-export-backend-name (plist-get info :back-end)))
             (chunk-style-fun (intern (concat "org-ravel-chunk-style-" 
                                              (symbol-name bkend)))))
        (if (and (string= lang "R") (fboundp chunk-style-fun))
            (funcall chunk-style-fun label ravel r-headers-attr
                     (car (org-export-unravel-code src-block)))
          (funcall          
           (org-ravel-get-ancestor-fun 'src-block info)
           src-block contents info)
          )))

(defun org-ravel-inline-src-block (inline-src-block contents info)
  "Transcode an INLINE-SRC-BLOCK element from Org to backend markup.
CONTENTS holds the contents of the item.  INFO is a plist holding
contextual information.  Use default for parent backend except for R calls."
  (let ((lang (org-element-property :language inline-src-block))
        (ancestor-inline-src-block 
         (org-ravel-get-ancestor-fun 'inline-src-block info))
        (inline-style-fun 
         (intern (concat "org-ravel-inline-style-" 
                         (symbol-name 
                          (org-export-backend-name (plist-get info :back-end))))))
        )
    (if (and (string= lang "R") (fboundp inline-style-fun))
        (funcall inline-style-fun inline-src-block contents info)
      (funcall ancestor-inline-src-block inline-src-block contents info)
      )))

(defadvice org-export-as (around org-ravel-export-as-advice protect)
   "Activate advise for `org-babel-exp-do-export' in `org-export-as'.
 This enables preproceesing of R inline src blocks and src blocks
 by babel before parsing of the *.org buffer ."
   (if (fboundp  (intern (concat "org-ravel-chunk-style-" (symbol-name backend))))
       (progn
         (add-hook 'org-export-before-parsing-hook 'org-ravel-strip-SRC-hookfun)
         (add-hook 'org-export-before-parsing-hook 'org-ravel-strip-header-hookfun)
         (ad-enable-advice 'org-babel-exp-do-export 'around 'org-ravel-exp-do-export)
         (ad-activate 'org-babel-exp-do-export)
         ad-do-it
         (ad-disable-advice 'org-babel-exp-do-export 'around 'org-ravel-exp-do-export)
         (ad-activate 'org-babel-exp-do-export)
         (remove-hook 'org-export-before-parsing-hook 'org-ravel-strip-SRC-hookfun)
         (remove-hook 'org-export-before-parsing-hook 'org-ravel-strip-header-hookfun))
     ad-do-it))

(ad-activate 'org-export-as)

(defun org-ravel-strip-SRC-hookfun ( backend )
  "Strip delimiters: ==SRC< and >SRC==. BACKEND is ignored."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "==SRC<\\(.*?\\)>SRC==" nil t)
      (replace-match "src_R\\1" nil nil))))

(defun org-ravel-strip-header-hookfun ( backend )
  "Strip #+header: ==<STRIP>==. BACKEND is ignored."
   (save-excursion
    (goto-char (point-min))
    (while (re-search-forward 
            "^[         ]*#\\+headers?:[        ]*==<STRIP>==[ ]\\([^\n]*\\)$" 
            nil t)
      (replace-match "\\1" nil nil))))

(defadvice org-babel-exp-do-export  (around org-ravel-exp-do-export)
  "Wrap the ravel src block template around body and clip results."
  (let ((is-R (string= (nth 0 info) "R"))
        (is-inline (eq type 'inline))
        (export-val (or (cdr (assoc :exports (nth 2 info))) "code"))
        (noweb-yes (string= "yes" (cdr (assoc :noweb (nth 2 info))))))
    (if is-R
        ;; pass src block to the parser
        (setq ad-return-value
              (if is-inline
                  ;; delimit src_R[]{} inside `==SRC<' and `>SRC=='
                  ;; it will be stripped just before parsing
                  ;; insert `:ravel' values, if any
                  (flet 
                   ((org-babel-examplify-region
                     (x y z)
                     (insert (format "==SRC<%s>SRC==" 
                                     (prog1 (buffer-substring x y)
                                       (delete-region x y)))))
                    (org-babel-execute:R
                     (body params)
                     (let* ((ravelarg 
                             (cdr (assoc :ravel (nth 2 info))))
                            (nth-one (nth 1 info))
                            (srcRresult
                             (if ravelarg
                                 (format "[ %s ]{%s}" ravelarg nth-one)
                               (format "{%s}"
                                       nth-one ))))
                       srcRresult)
                     ))
                   (let ((org-confirm-babel-evaluate nil))
                     ad-do-it))
                ;; #+begin_src ... #+end_src block
                ;; omit if results type none
                (if (string= export-val "none")
                    ""
                  ;; prune out any in buffer results
                  (org-babel-remove-result info)
                  (let* ((headers (nth 2 info))
                         (ravelarg (cdr (assoc :ravel headers)))
                         (non-ravelargs
                          (mapconcat 
                           '(lambda (x) (format "%S %s" (car x) (cdr x)))
                           (assq-delete-all :ravel headers) " ")))
                    (format "%s%s#+BEGIN_SRC R \n%s\n#+END_SRC"
                            (if ravelarg
                                (format "#+header: ==<STRIP>== #+ATTR_RAVEL: %s\n" ravelarg) "")
                            (if non-ravelargs
                                (format "#+header: ==<STRIP>== #+ATTR_R-HEADERS: %s\n" 
                                        non-ravelargs) "")
                            (if noweb-yes
                                (org-babel-expand-noweb-references
                                 info
                                 org-babel-exp-reference-buffer)
                              (nth 1 info)))))))
      ;; not R so do default
      ad-do-it)))

(defun org-ravel-insert-src-block-name-as-chunk ()
  "insert src block name in << >>."
(interactive)
 (let
     ((bname
       (org-icompleting-read
        "source-block name: " (org-babel-src-block-names) nil t)))
   (insert (format "<<%s>>" bname))))

(provide 'ox-ravel)

;;; ox-ravel.el ends here
