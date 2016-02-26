;; that's a cleaned version of the .emacs for a "vanilla" Emacs
;; We're adding our own set of of extensions and are in addition
;; overwriting the org-mode that comes with Emacs.

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Setting the font
;;
;; These fonts have to be installed manually! (M-x describe-font)
;; the one below works nice on MacOS with retina display.
;; monofur.
;(set-default-font "-*-monofur-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;(set-face-attribute 'default nil :font "-*-monofur-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;; have to set the following two, in order to
;(set-face-attribute 'fixed-pitch nil :font "-*-monofur-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;(set-face-attribute 'variable-pitch nil :font "-*-monofur-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")

;; inconsolata.
;(set-default-font "-*-Inconsolata-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;(set-face-attribute 'default nil :font "-*-Inconsolata-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;; have to set the following two, in order to
;(set-face-attribute 'fixed-pitch nil :font "-*-Inconsolata-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;(set-face-attribute 'variable-pitch nil :font "-*-Inconsolata-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")

;; old stuff.
;(set-default-font
; "-apple-inconsolata-medium-r-normal--11-*-*-*-*-*-iso10646-1")
;; other examples.
;(set-default-font
; "-*-HyperFont-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")
;(set-default-font
; "-*-Ubuntu Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;(set-default-font
;    "-apple-Source_Code_Pro-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")
;(add-to-list 'default-frame-alist '(font . "-apple-Source_Code_Pro-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1"))
;(set-default-font
;    "-apple-Osaka-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;;
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MAC specific settings
;;
;; manually specify the path!
(setenv "PATH"
    (concat (getenv "PATH")
    ":~/bin:/usr/local/bin:/usr/bin:/bin"))
;; in order to be able to write {} and []
(setq default-input-method "MacOSX")
(setq ns-alternate-modifier 'meta)        ;; left alt is meta
(setq ns-right-alternate-modifier 'nil)   ;; right alt is alt
(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
;(mouse-wheel-mode t)			; activate mouse scrolling
(global-font-lock-mode nil)		; syntax highlighting
(transient-mark-mode nil)			; sane select (mark) mode
;(delete-selection-mode t)		; entry deletes marked text
;(show-paren-mode t)			; match parentheses
;(add-hook 'text-mode-hook 'turn-on-auto-fill) ; wrap long lines in text mode
;;
;;;;


;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; custom settings
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "23b47c2d54f337b30b4a14bdea6be888482a56f1bbe1ff74d9b2ea0e2c943446" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "dc2ae53baca6dabf168ddc038e3c5add1a34a1947087e778e9d14f0e2d4b89a2" default)))
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(safe-local-variable-values
   (quote
    ((org-docco-doccoize-me . t)
     (org-export-html-style-include-default)
     (org-export-html-postamble))))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;
;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; other settings
;;
;; line wrapping and similar...
(setq-default word-wrap t)
(show-paren-mode 1)
(setq-default show-paren-mode t)		; match parenthesis
(setq-default tool-bar-mode nil)		; hide the button/menu bar
(setq auto-fill-mode -1)
;;(setq-default fill-column 99999) ;; if everything else fails
;;(setq fill-column 99999)         ;; if everything else fails
(remove-hook 'text-mode-hook 'turn-on-auto-fill)
;; show line numbers by default. use "M-x linum-mode" to toggle
(global-linum-mode nil)
(setq make-backup-files nil)
;; other settings
;;(add-hook 'text-mode-hook 'turn-on-visual-line-mode)  ;; visual line mode on only in text files.
;; disable debug on error
(setq debug-on-error 1)
;;
;; kill all other buffers, except the current one.
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer)))
  )
;; add shortcut
(global-set-key (kbd "C-c k") 'kill-other-buffers)
;;
;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Themes:
;;
;; Themes, load with "M-x load-theme"
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'zenburn t)
(load-theme 'solarized-dark t)
;(load-theme 'mccarthy t)
;; solarized customization
;; make the fringe stand out from the background
;(setq solarized-distinct-fringe-background t)
;; make the modeline high contrast
;(setq solarized-high-contrast-mode-line t)
;; load the solarized-light theme by default
;(load-theme 'solarized-light t)
;;
;;;;;;;;;;;;;;;
;; transparency
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
; (set-frame-parameter (selected-frame) 'alpha '(100 85))
; (add-to-list 'default-frame-alist '(alpha 100 85))
;(eval-when-compile (require 'cl))
; (defun toggle-transparency ()
;   (interactive)
;   (if (/=
;        (cadr (frame-parameter nil 'alpha))
;        100)
;       (set-frame-parameter nil 'alpha '(100 100))
;     (set-frame-parameter nil 'alpha '(90 85))))
; (global-set-key (kbd "C-c t") 'toggle-transparency)
;;
;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Packages and stuff


;;;;;;;;;;;;;;;;;;;;;;;;
;; from https://github.com/purcell/exec-path-from-shell.git
;; Load environment variables from the shell
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;; loading additional environment variables.
(exec-path-from-shell-copy-env "PERL5LIB")
(exec-path-from-shell-copy-env "LC_ALL")    ; this somehow prevents segfauls of R parallel processing in Emacs
(exec-path-from-shell-copy-env "LANG")    ; this somehow prevents segfauls of R parallel processing in Emacs
(exec-path-from-shell-copy-env "SHELL")
;;
;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;
;; ;; AUCTex
;; ;;
;; ;; path where auctex has been installed...
;; (add-to-list 'load-path "~/.emacs.d/site-lisp")
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;; ;; Turn on RefTeX for LaTeX documents. Put further RefTeX
;; ;; customizations in your .emacs file.
;; ;(add-hook 'LaTeX-mode-hook
;; ;      (lambda ()
;; ;	(turn-on-reftex)
;; ;	(setq reftex-plug-into-AUCTeX t)))
;; ;(add-hook 'TeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTeX t)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; ;; Minimal OS X-friendly configuration of AUCTeX. Since there is no
;; ;; DVI viewer for the platform, use pdftex/pdflatex by default for
;; ;; compilation. Furthermore, use 'open' to view the resulting PDF.
;; ;; Until Preview learns to refresh automatically on file updates, Skim
;; ;; (http://skim-app.sourceforge.net) is a nice PDF viewer.
;; (setq TeX-PDF-mode t)
;;     (setq TeX-view-program-selection
;;     '(((output-dvi style-pstricks)
;;         "dvips and PDF Viewer")
;;         (output-dvi "PDF Viewer")
;;         (output-pdf "PDF Viewer")
;;         (output-html "Safari")))
;;         (setq TeX-view-program-list
;;         '(("dvips and PDF Viewer" "%(o?)dvips %d -o && open %f")
;;         ("PDF Viewer" "open %o")
;;         ("Safari" "open %o")))
;; ;; Add standard Sweave file extensions to the list of files recognized
;; ;; by AUCTeX.
;; (setq TeX-file-extensions
;;       '("Rnw" "rnw" "Snw" "snw" "tex" "sty" "cls" "ltx" "texi" "texinfo" "dtx" "Rd"))
;; ;; code folding:
;; ;(add-hook 'TeX-mode-hook (lambda ()
;; ;			   (Tex-fold-mode 1)))
;; ;;
;; ;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; outline-minor-mode
;;
;(defun turn-on-outline-minor-mode()
;  (outline-minor-mode 1))
;(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
;(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
;(setq outline-minor-mode-prefix "C-c C-o")
;; C-c C-o C-l hide section content
;; C-c C-o C-n move to next section
;; C-c C-o C-p previous section
;; C-c C-o C-a show all
;;
;;;;


;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ESS
;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/ess")
(require 'ess-site)
(require 'ess-eldoc)
(setq-default inferior-R-args "--no-save ")
;; automatically start R in the present directory. useful for async org export
(setq ess-ask-for-ess-directory nil)
;; toggle the option to ask for R to start.
(defun toggle-ask-R ()
  "Toggle the option for ESS to ask to start R in directory or to just start it."
    (interactive)
      (if (eq ess-ask-for-ess-directory nil)
            (setq ess-ask-for-ess-directory t)
                (setq ess-ask-for-ess-directory nil)))
;; This will set Ctrl-g to toggle but you can set it to anything
;; you want.
(global-set-key [(control meta g)] 'toggle-ask-R)
;; Automagically delete trailing whitespace when saving R script
;; files. One can add other commands in the ess-mode-hook below.
;; (add-hook 'ess-mode-hook
;;       '(lambda()
;; 	(add-hook 'write-file-functions
;; 	(lambda ()
;; 	(ess-nuke-trailing-whitespace)))
;; 	(setq ess-nuke-trailing-whitespace-p t)))
;;
;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tramp for remote ssh/files etc.
;;
;; tramp (transparent remote ...)
(require 'tramp)
(setq tramp-default-method "ssh")
;(setq tramp-chunksize 500)
;(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
;(setq tramp-debug-buffer t)
;(setq tramp-verbose 10)
;;
;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;
;; At first, we make sure that our modifications in .emacs
;; are applied _after_ default.el is read/
;; Note: org is a part of Emacs, so we have to overwrite! the files
;; in /Applications/Emacs.app/Contents/Resources etc:
;; load a separately installed org
;; (add-to-list 'load-path "/Applications/Emacs.app/Contents/Resources/lisp/org")
;; Configuring org mode to know about R and set some reasonable default behavior
;; We're loading a different version of the org-mode, i.e. an older version.
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-async")
(require 'ess-site)
;(require 'org-install)
(require 'ob-tangle)
(require 'ob-latex)
(require 'ob-R)
;(require 'ob-shell)
;(require 'ob-sh)
(require 'ox-latex)
(require 'ox-html)
(require 'ox-beamer)
(require 'ox-md)
;;(require 'ox-bibtex)
;(require 'org-eval)
;(setq org-startup-indented t)  ;; automatic indentation and hiding of **
;; bullets for TODO items
;(require 'org-bullets)
;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; set org-mode for all .org files.
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; scale images by default to 400px, otherwise (if there is an #+ATTR.* :width 200px to 200)
; load R and some other languages language...
(org-babel-do-load-languages 'org-babel-load-languages '((R . t)
							 (emacs-lisp . t)
							 (sqlite . t)
							(latex . t)))
;; save the window set-up; forces the layout to be restore after agenda is closed.
(setq org-agenda-window-setup 'current-window)
;; automatically add all org files as agenda files.
;; just add all folders you want to be screened.
(load-library "find-lisp")

;; only calls find-lisp-find-files if the directory exists.
(defun find-lisp-find-files-if-exists (directory regexp)
  (if (file-exists-p directory)
      (find-lisp-find-files directory regexp)
    )
  )

(add-hook 'org-agenda-mode-hook (lambda ()
    (setq org-agenda-files
    (append (find-lisp-find-files-if-exists "~/R-workspaces/2013" "\.org$")
	    (find-lisp-find-files-if-exists "~/R-workspaces/2014" "\.org$")
	    (find-lisp-find-files-if-exists "~/R-workspaces/2012" "\.org$")
	    (find-lisp-find-files-if-exists "~/R-workspaces/2011" "\.org$")
	    (find-lisp-find-files-if-exists "/Volumes/EURACrypt/2014" "\.org$")
	    (find-lisp-find-files-if-exists "~/R-workspaces/Collaborations" "\.org$")
	    (find-lisp-find-files-if-exists "~/Documents/Unison/org-files" "\.org$")
	    (find-lisp-find-files-if-exists "~/Documents/Unison/Documents/Papers-own" "\.org$")
	    (find-lisp-find-files-if-exists "~/Documents/Unison/Documents/Reviews" "\.org$")
	    (find-lisp-find-files-if-exists "~/Projects/git" "\.org$")
    ))
))
;; define custom TODO keywords.
(setq org-todo-keywords
       '((sequence "TODO(t)" "WAIT(w@/!)" "VERIFY(v@)" "REDO(r@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(setq org-todo-keyword-faces
	'(("TODO" . (:foreground "DeepPink1" :weight bold :slant italic :underline t))
	("WAIT" . (:foreground "CornflowerBlue" :slant italic :underline t))
	("DONE" . (:foreground "forest green" :slant italic :undeline t))
	("CANCELED" . (:foreground "SeaGreen" :weight bold :slant italic :underline t))
	("REDO" . (:foreground "DeepPink1" :weight bold :slant italic :underline t))
	("VERIFY" . (:foreground "DarkOrange1" :weight bold :slant italic :underline t))
	))
;; we don't want to always say "yes" please execute code...
(setq org-confirm-babel-evaluate nil)
;; define a org-to-latex template
;(setq org-export-latex-listings t)
;(setq org-export-latex-listings 'minted)
;; show created images inline in the org buffer, just have to find a way to reduce their size...
;(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
;(add-hook 'org-mode-hook 'org-display-inline-images)
;; modify the pdf process. (idea: call latexmk -C %f afterwards?)
(setq org-latex-pdf-process (quote ("latexmk -pdflatex='pdflatex --shell-escape' -latex='latex --shell-escape' -gg -f -cd -pdf %f")))
(setq org-latex-listings 'minted
      org-latex-minted-options
      '(
	;;	("frame" "lines")
	("bgcolor" "lightgrey")
        ("fontsize" "\\scriptsize")
	;;        ("linenos" "")
	)
      )
;; additional latex packages we always want to be added for latex export.
(add-to-list 'org-latex-packages-alist '("" "minted"))
(add-to-list 'org-latex-packages-alist '("" "float"))
(add-to-list 'org-latex-packages-alist '("" "xcolor"))
;; default skeleton for org files:
(define-skeleton org-skeleton
    "Header info for a emacs-org file."
    "Title: "
    "#+TITLE:" str " \n"
    "#+AUTHOR: Johannes Rainer\n"
    "#+email: johannes.rainer@eurac.edu\n"
    "#+OPTIONS: ^:{}\n"
    "#+PROPERTY: exports code \n"
    "#+PROPERTY: session *R*\n"
    "#+PROPERTY: noweb yes\n"
    "#+PROPERTY: results output\n"
    "#+PROPERTY: tangle yes\n"
    "#+STARTUP: overview\n"
    "#+INFOJS_OPT: view:t toc:t ltoc:t mouse:underline buttons:0 path:http://thomasf.github.io/solarized-css/org-info.min.js\n"
    "#+HTML_HEAD: <link rel='stylesheet' type='text/css' href='http://thomasf.github.io/solarized-css/solarized-light.min.css' />\n"
    "#+LATEX_HEADER: \\usepackage[backend=bibtex,style=chem-rsc,hyperref=true]{biblatex}\n"
    "#+LATEX_HEADER: \\usepackage{parskip}\n"
    "#+LATEX_HEADER: \\usepackage{tabu}\n"
    "#+LATEX_HEADER: \\usepackage{float}\n"
    "#+LATEX_HEADER: \\usepackage{xcolor}\n"
    "#+LATEX_HEADER: \\setlength{\\textwidth}{17.0cm}\n"
    "#+LATEX_HEADER: \\setlength{\\hoffset}{-2.5cm}\n"
    "#+LATEX_HEADER: \\setlength{\\textheight}{22cm}\n"
    "#+LATEX_HEADER: \\setlength{\\voffset}{-1.5cm}\n"
    "#+LATEX_HEADER: \\addbibresource{~/Documents/Unison/bib/references.bib}\n"
    "# #+LATEX_HEADER: \\usepackage{verbatim}\n"
    "#+LATEX_HEADER: \\usepackage{inconsolata}\n"
    "#+LATEX_HEADER: \\definecolor{lightgrey}{HTML}{F0F0F0}\n"
    "#+LATEX_HEADER: \\definecolor{solarizedlightbg}{HTML}{FCF4DC}\n"
    "#+LATEX_HEADER: \\makeatletter\n"
    "# #+LATEX_HEADER: \\def\\verbatim@font{\\scriptsize\\ttfamily}\n"
    "#+LATEX_HEADER: \\makeatother\n"
    "-----"
)
(global-set-key [C-S-f4] 'org-skeleton)
;(add-hook 'org-export-before-processing-hook 'org-export-process-apply-macros)
;; place captions below tables, not above
;;(setq org-latex-table-caption-above nil)
(setq org-export-latex-table-caption-above nil)
;; these custom agenda views will be displayed in the org-mobile app
(setq org-tag-alist '(("analysis" . ?n) ("collab" . ?c) ("EURAC" . ?E) ("facility" . ?f) ("paper" . ?a) ("private" . ?p) ("project" . ?P)  ("review" . ?r) ("seminar" . ?s) ("Tanya" . ?t) ("work" . ?w) ("@brixen" . ?b) ("@innsbruck" . ?i) ("@meran" . ?m) ("@office" . ?o) ))
(setq org-agenda-custom-commands
      '(("p" "Private TODOs"
	 ((tags-todo "private-@innsbruck-@meran-@brixen-@office")
	  (tags-todo "private+@innsbruck")
	  (tags-todo "private+@meran")
	  (tags-todo "private+@brixen")
	  (tags-todo "private+@office")
	  ))
	("w" "Work related TODOs"
	 ((tags-todo "work-analysis-collab-paper-project-EURAC-facility-tanya")
	 (tags-todo "work+analysis")
	 (tags-todo "work+collab")
	 (tags-todo "work+facility")
	 (tags-todo "work+paper")
	 (tags-todo "work+project")
	 (tags-todo "work+tanya")
	 (tags-todo "work+EURAC")
	 ))
))
;; try this for gplots evaluation
(setq org-babel-use-quick-and-dirty-noweb-expansion t)
;;
;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit, git control
;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit")
(require 'magit)
;(require 'magit-svn)
;; define the directories in which magit is looking for repos
;(setq magit-repo-dirs
;      (list "~/R-workspaces"
;	    "~/Projects-synced"
;	    "~/Projects"
;	    "~/Documents/Unison/"
;))
(setq magit-repo-dirs-depth 4)
;;
;;;;

;;;;
;; the ox-ravel Sweave export module
(require 'ox-ravel)
;;
;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;
;; ssh
;;
(require 'ssh)
(setq ssh-display-follow-current-frame t)
(setq ssh-explicit-args '("-Y"))
;;
;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;
;; other stuff from Vince Gaulet's Emacs:
;;
(add-to-list 'vc-handled-backends 'SVN)
(require 'psvn)
(require 'framepop)
;(require 'import-env-from-shell)
;;
;;;;

;;;;;;;;;;;;;;
;; Melpa
;;
;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;                         ("marmalade" . "http://marmalade-repo.org/packages/")
;                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			("melpa" . "http://melpa.milkbox.net/packages/")))
;;
;;;;

;;;;;;;;;;;;;;;
;; perl
;; use cperl-mode instead of perl-mode for perl.
(defalias 'perl-mode 'cperl-mode)
;;
;;;;

