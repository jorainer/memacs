;; that's a cleaned version of the .emacs for a "vanilla" Emacs
;; We're adding our own set of of extensions and are in addition
;; overwriting the org-mode that comes with Emacs.

;;; * Font
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Setting the font
;;
;; These fonts have to be installed manually! (M-x describe-font)
;; the one below works nice on MacOS with retina display.

;; Hack
;; (set-default-font "-*-Hack-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'default nil :font "-*-Hack-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1")
;; ;; have to set the following two, in order to
;; (set-face-attribute 'fixed-pitch nil :font "-*-Hack-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'variable-pitch nil :font "-*-Hack-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1")

;; inconsolata.
;; (add-to-list 'default-frame-alist '(font . "Inconsolata-14"))
;; (set-face-attribute 'default t :font "Inconsolata-14")
;; have to set the following two, in order to
;;(set-face-attribute 'fixed-pitch nil :font "-*-Inconsolata-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")
;;(set-face-attribute 'variable-pitch nil :font "-*-Inconsolata-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")

;; Source Code Pro
;;(set-default-font "Source Code Pro for Powerline")
(add-to-list 'default-frame-alist '(font . "Source Code Pro-14"))
(set-face-attribute 'default t :font "Source Code Pro-14")

;; Apple SF font
;; (set-default-font "SF Mono-14")
;;* (add-to-list 'default-frame-alist '(font . "SF Mono-14"))
;;* (set-frame-font "SF Mono-14" nil t)
;;(set-face-attribute 'default t :font "SF Mono-14")
;;(set-default-font "-*-SF Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;;(set-face-attribute 'default nil :font "-*-SF Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")

;; Fantasque Sans Mono (https://github.com/belluzj/fantasque-sans)
;; (add-to-list 'default-frame-alist '(font . "Fantasque Sans Mono-13"))
;; (set-face-attribute 'default t :font "Fantasque Sans Mono-13")
;; Set the pitch if e.g. TODO should have the same size than the header.
;;(set-default-font "-*-Fantasque Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;;(set-face-attribute 'default nil :font "-*-Fantasque Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'default nil :font "Fantasque Sans Mono")
;; have to set the following two, in order to
;;(set-face-attribute 'fixed-pitch nil :font "Fantasque Sans Mono")
;;(set-face-attribute 'variable-pitch nil :font "Fantasque Sans Mono")
;;
;;;

;;; * MAC specific settings
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MAC specific settings
;;
;; manually specify the path!
(setenv "PATH"
	(concat ":/Users/jo/bin:/usr/local/bin:/usr/bin:/bin"
	(getenv "PATH"))
	)
(add-to-list 'exec-path "/Users/jo/bin/")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/bin")

;; This is from https://gist.github.com/railwaycat/3498096
;; Keybonds
(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(hyper z)] 'undo)

;; mac switch meta key
(defun mac-switch-meta nil 
  "switch meta between Option and Command"
  (interactive)
  (if (eq mac-option-modifier nil)
      (progn
	(setq mac-option-modifier 'meta)
	(setq mac-command-modifier 'hyper)
	)
    (progn 
      (setq mac-option-modifier nil)
      (setq mac-command-modifier 'meta)
      )
    )
  )
(mac-switch-meta)
(mac-switch-meta)

;; in order to be able to write {} and []
;; (setq default-input-method "MacOSX")

;; (setq ns-alternate-modifier 'meta)        ;; left alt is meta
;; (setq ns-right-alternate-modifier 'nil)   ;; right alt is alt
;(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
;(mouse-wheel-mode t)			; activate mouse scrolling
(global-font-lock-mode t)		; syntax highlighting
(setq global-visual-line-mode t)	; soft-wrapping of long lines
;(setq font-lock-global-modes '(not ESS))
(transient-mark-mode t)			; sane select (mark) mode
;(delete-selection-mode t)		; entry deletes marked text
;(show-paren-mode t)			; match parentheses
;;
;;;;

;;; * Custom variables
;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; custom settings
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#c5c8c6"))
 '(beacon-color "#cc6666")
 '(custom-safe-themes
   '("a06658a45f043cd95549d6845454ad1c1d6e24a99271676ae56157619952394a" default))
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'dark)
 '(helm-completion-style 'emacs)
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(package-selected-packages
   '(helm-bibtex bibtex-completion exec-path-from-shell auto-dictionary spaceline editorconfig imenu-list magit poly-R poly-markdown polymode markdown-preview-mode markdown-mode ess company-rtags company-ctags helm-company helm org-bullets org-plus-contrib))
 '(spaceline-helm-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68")))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Packages and stuff
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)

;;; * company-mode
;;;;;;;;;;;;;;;;;;;;;;;
;;
;; company-mode
(require 'company)
(require 'company-rtags)
;; cancel if input doesn't match, be patient, and don't complete automatically.
;; set company-idle-delay nil for no automatic matching.
(setq company-require-match nil
      company-async-timeout 6
      company-idle-delay 1)
(setq company-backends
      '(company-files company-capf company-gtags company-rtags company-ispell company-nxml
		      company-css company-cmake company-semantic))
(setq-default company-backends
              '(company-files company-capf company-rtags company-gtags company-ispell
			      company-nxml company-css company-cmake company-semantic))
(add-hook 'after-init-hook 'global-company-mode)
;;
;;;;

;;; * helm
;;;;;;;;;;;;;;;;;;;;;;;
;;
(require 'helm-config)
(require 'helm)
;; Overwrite key bindings
(global-set-key (kbd "M-x") 'helm-M-x)
;;(global-set-key (kbd "C-x b") 'helm-buffer-list)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; bind also cmd-v to that
;;(global-set-key (kbd "s-v") 'helm-show-kill-ring)
;; rebind <tab> to run persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; open helm buffer inside current window
(setq helm-split-window-in-side-p t)
;; Turn on helm by default
(helm-mode 1)

;;; * helm-complete
;;;;;;;;;;;;;;;;;;;;;;;
;;
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))
;; (global-set-key "\t" 'helm-company)
(define-key company-mode-map (kbd "<C-tab>") 'helm-company)
;;
;;;;

;;;;
;; helm-bibtex
;; https://github.com/tmalsburg/helm-bibtex 
;; Install via melpa with package-install
(require 'helm-bibtex)
(setq bibtex-completion-bibliography
      '("/Users/jo/ownCloud/bib/references_all.bib"))


;;; * ESS
;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ESS
;;
(setq ess-r-versions '("R" "R-3" "R-"))
(load "ess-site")
;; (require 'ess-r-mode)
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
;;? (setq eldoc-echo-area-use-multiline-p t)
;; Don't use a R history file.
(setq ess-history-file nil)
;; Uncomment below if we're getting problems doing an ediff on an R-file with magit. merge conflict
;; (add-to-list 'auto-mode-alist '("\\.R" . ess-mode))
(add-to-list 'auto-mode-alist '("NAMESPACE" . ess-mode))
;;(require 'ess-custom)
;; Somehow that sucker seems to be missing...
;;(defvar ess-local-customize-alist nil "Buffer local settings for proper behaviour")
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
(ess-toggle-underscore nil)

;;; * org-mode
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
;(require 'org-install)
(require 'ob-tangle)
(require 'ob-latex)
(require 'ob-R)
(require 'ob-shell)
;(require 'ob-sh)
;(require 'ox-latex)
(require 'ox-html)
(require 'ox-beamer)
(require 'ox-md)
;(setq org-startup-indented t)  ;; automatic indentation and hiding of **
;; bullets for TODO items
(require 'org-bullets)
;; Override the bullets.
(setq org-bullets-bullet-list '(
				"◉"
				"●"
				"○"
				"▶"
				"◆"
				"◇"
				))
;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; set org-mode for all .org files.
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; ;; Disable the strike through:
;; (setq org-emphasis-alist (quote (("*" bold)
;; 				 ("/" italic)
;; 				 ("_" underline)
;; 				 ("=" org-code verbatim)
;; 				 ("~" org-verbatim verbatim))))
;; Hide the markup elements:
(setq org-hide-emphasis-markers t)
;; set to nil in case no default scaling should be done.
;; globally disabling sub and superscripts...
(setq org-export-with-sub-superscripts '{})
(setq org-use-sub-superscripts '{})
;; load R and some other languages language...
(org-babel-do-load-languages 'org-babel-load-languages '((R . t)
							 (emacs-lisp . t)
							 (sqlite . t)
							 (latex . t)
							 (ditaa . t)))
;; save the window set-up; forces the layout to be restore after agenda is closed.
(setq org-agenda-window-setup 'current-window)
;; treat lists like headers:
(setq org-cycle-include-plain-lists 'integrate)
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
	  (append
	  ;; (find-lisp-find-files-if-exists "~/R-workspaces/2012" "\.org$")
	  ;; (find-lisp-find-files-if-exists "~/R-workspaces/2011" "\.org$")
	  ;; (find-lisp-find-files-if-exists "~/R-workspaces/2013" "\.org$")
	   (find-lisp-find-files-if-exists "~/R-workspaces/2014" "\.org$")
	   (find-lisp-find-files-if-exists "/Volumes/EURACrypt/2014" "\.org$")
	   (find-lisp-find-files-if-exists "/Volumes/EURACrypt/2015" "\.org$")
	   (find-lisp-find-files-if-exists "~/R-workspaces/Collaborations" "\.org$")
	   (find-lisp-find-files-if-exists "~/Documents/Unison/org-files" "\.org$")
	   (find-lisp-find-files-if-exists "~/Documents/Unison/Documents/Papers-own" "\.org$")
	   (find-lisp-find-files-if-exists "~/Documents/Unison/Documents/Reviews" "\.org$")
	   (find-lisp-find-files-if-exists "~/Documents/Unison/EURAC" "\.org$")
	   (find-lisp-find-files-if-exists "~/Projects/git" "\.org$")
    ))
))
;; define custom TODO keywords.
(setq org-todo-keywords
       '((sequence "TODO(t)" "WAIT(w@/!)" "IN PROGRESS(i@)" "REDO(r@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(setq org-todo-keyword-faces
;	'(("TODO" . (:foreground "DeepPink1" :weight bold :slant italic :underline t))
	'(("TODO" . (:foreground "#f39c12" :weight bold :slant italic :underline t))
	("WAIT" . (:foreground "#3498db" :slant italic :underline t))
	("DONE" . (:foreground "#27ae60" :slant italic :undeline t))
	("CANCELED" . (:foreground "#9b59b6" :weight bold :slant italic :underline t))
	("REDO" . (:foreground "#e74c3c" :weight bold :slant italic :underline t))
	("IN PROGRESS" . (:foreground "#e74c3c" :weight bold :slant italic :underline t))
	))
;; we don't want to always say "yes" please execute code...
(setq org-confirm-babel-evaluate nil)
(setq org-latex-listings 'minted)
;; modify the pdf process. (idea: call latexmk -C %f afterwards?)
(setq org-latex-pdf-process (quote ("latexmk -pdflatex='pdflatex --shell-escape' -latex='latex --shell-escape' -gg -f -cd -pdf %f")))
(setq org-latex-listings 'minted
      org-latex-minted-options
      '(
	;; ("frame" "lines")
	("bgcolor" "lightgrey")
        ("fontsize" "\\scriptsize")
	;; ("linenos=true")
	;; ("linenos" "")
	)
      )
;; additional latex packages we always want to be added for latex export.
(add-to-list 'org-latex-packages-alist '("" "minted"))
(add-to-list 'org-latex-packages-alist '("" "float"))
(add-to-list 'org-latex-packages-alist '("" "xcolor"))

;; place captions below tables, not above
(setq org-latex-caption-above nil)
(setq org-export-latex-table-caption-above nil)
;; org-export settings:
;; allows to define a init file other than the default one, specifically
;; useful if async export yields e.g. an error complaining that the font
;; can not be found.
(setq org-export-async-init-file "/Users/jo/.emacs-async-init.el")
;; try this for gplots evaluation
(setq org-babel-use-quick-and-dirty-noweb-expansion t)
;; Disable company mode in org buffers
(add-hook 'org-mode-hook (lambda() (company-mode -1)))
;;
;;;;

;;; * markdown
;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown
;;
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(setq markdown-header-scaling t)
(setq markdown-hide-markup nil)

;;; * polymode
;;;;;;;;;;;;;;;;;;;;;;;;
;; polymode
;;
(setq load-path
      (append '("~/.emacs.d/site-lisp/polymode/"
		"~/.emacs.d/site-lisp/poly-R/"
		"~/.emacs.d/site-lisp/poly-markdown/"
		"~/.emacs.d/site-lisp/poly-noweb/")
	      load-path))
;;(require 'poly-base)
(require 'poly-R)
(require 'poly-markdown)
;; (require 'poly-noweb)
;; (require 'poly-C)
;; (require 'poly-slim)
;; (require 'poly-erb)
;; (require 'poly-org)

;;; * magit
;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit, git control
;;
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/magit")
(require 'magit)
;; (setq magit-repo-dirs-depth 4)
;;
;;;;

;;; * Spell checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell checking
;;
;; use aspell instead of ispell:
(setq-default ispell-program-name "aspell")  ;; or just symlink ispell to aspell...
; enable spell checking using flyspell for Tex, latex and org-mode,
; disable for ess.
(add-hook 'TeX-mode-hook
	  (lambda()
	    (flyspell-mode 1))
	    )
(add-hook 'latex-mode-hook
	  (lambda()
	    (flyspell-mode 1))
	    )
(add-hook 'org-mode-hook
	  (lambda()
	    (flyspell-mode 1))
	    )
(add-hook 'markdown-mode-hook
	  (lambda()
	    (flyspell-mode 1))
	    )
(add-hook 'ess-mode-hook
	  (lambda()
	    (flyspell-mode 0))
	  )
(setq ispell-list-command "--list")
;;
;;;

;;; ** perl
(defalias 'perl-mode 'cperl-mode)

;;; ** TAGS
(visit-tags-table "/Users/jo/Projects/git/TAGS")
(setq tags-table-list
      '("/Users/jo/Projects/git/"))

;; ;;; ** Fill-Column-Indicator
;; Disable this vertical line for e.g. presentations.
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
;; (setq-default fci-rule-image-format 'pbm)
;; ;;(setq-default fci-rule-image-format 'xpsm)
;; (setq fci-handle-truncate-lines nil)
;; ;; comment below if you want to use the image option.
;; ;; (setq fci-always-use-textual-rule "yes")
;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (global-fci-mode 1)
(defun auto-fci-mode (&optional unused)
  (if (window-system)
      (if (> (window-width) fci-rule-column)
	  (fci-mode 1)
	(fci-mode 0))
    ))
(add-hook 'after-change-major-mode-hook 'auto-fci-mode)
(add-hook 'window-configuration-change-hook 'auto-fci-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; * Unsorted other settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; other settings
;;
;; line wrapping and similar...
;;(setq-default word-wrap t)
;;(electric-indent-mode 1)
(show-paren-mode 1)
(setq-default show-paren-mode t)		; match parenthesis
(setq-default tool-bar-mode nil)		; hide the button/menu bar
;;(setq auto-fill-mode -1)
;;(setq-default fill-column 99999) ;; if everything else fails
;;(setq fill-column 99999)         ;; if everything else fails
(add-hook 'text-mode-hook 'turn-on-auto-fill) ; wrap long lines in text mode
(setq-default fill-column 80)
;; Prevent line breaks in markdown code ``` definition.
(defun markdown-line-is-code-block-p ()
  "Return whether the current line is a code block."
  (save-excursion
    (move-beginning-of-line 1)
    (and (looking-at-p markdown-regex-gfm-code-block-open))))
(add-hook 'fill-nobreak-predicate #'markdown-line-is-code-block-p)
;; show line numbers by default. use "M-x linum-mode" to toggle
;;(global-linum-mode nil)
(setq make-backup-files nil)
;; other settings
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)  ;; visual line mode on only in text files.
;; disable debug on error
(setq debug-on-error nil)
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
;; from https://github.com/purcell/exec-path-from-shell.git
;; Load environment variables from the shells
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;; loading additional environment variables.
(exec-path-from-shell-copy-env "PERL5LIB")
(exec-path-from-shell-copy-env "LC_ALL")    ; this somehow prevents segfauls of R parallel processing in Emacs
(exec-path-from-shell-copy-env "LANG")    ; this somehow prevents segfauls of R parallel processing in Emacs
(exec-path-from-shell-copy-env "SHELL")
(exec-path-from-shell-copy-env "MYSQL_HOST")
(exec-path-from-shell-copy-env "MYSQL_USER")
(exec-path-from-shell-copy-env "MYSQL_PASS")
(exec-path-from-shell-copy-env "SHELL_MYSQL_HOST")
(exec-path-from-shell-copy-env "SHELL_MYSQL_USER")
(exec-path-from-shell-copy-env "SHELL_MYSQL_PASS")
;;

;;;;
;; Org mode inline image size.
;; show created images inline in the org buffer, just have to find a way to reduce their size...
;; (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
;; (add-hook 'org-mode-hook 'org-display-inline-images)
;; scale images by default to 400px, otherwise (if there is an #+ATTR_ORG: :width 200px to 200)
;;(setq org-image-actual-width '(200))
;;(setq org-image-actual-width nil)
;; Scale images to half window width
(setq org-image-actual-width (/ (window-pixel-width) 2))
;;(setq org-image-actual-width (/ (display-pixel-width) 2))
(defun org-inline-image-resize ()
  "Update the org-mode inline image width"
  (interactive)
  (setq org-image-actual-width (/ (window-pixel-width) 2))
  )
(add-hook 'window-configuration-change-hook #'org-inline-image-resize)

(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
 (autoload 'csv-mode "csv-mode"
   "Major mode for editing comma-separated value files." t)

;;;;
;; imenu-list
(require 'imenu-list)
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t)
;;(setq imenu-list-auto-resize t)
;;
;;;;
;;(require 'imenu+)

;;;;
;; editorconfig
(require 'editorconfig)
(editorconfig-mode 1)

;;;;
;; spaceline
(require 'spaceline-config)
;;(spaceline-spacemacs-theme)
(spaceline-emacs-theme)

;;; ** zoom-frame
(require 'zoom-frm)
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(global-set-key (kbd "C-x C-+") 'zoom-in)
(global-set-key (kbd "C-x C--") 'zoom-out)

;;; * Themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Themes, load with "M-x load-theme"
(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/themes/gruvbox2/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/gruvbox2/")
;(load-theme 'zenburn t)
;(load-theme 'leuven t)
;(load-theme 'mccarthy t)
;; solarized customization
;; make the fringe stand out from the background
;(setq solarized-distinct-fringe-background t)
;; make the modeline high contrast
;;(setq solarized-high-contrast-mode-line t)
;;;;;;;;;;;;;
;;
;; flatui:
;; (setq flatui-high-contrast-mode-line t)
;; (setq flatui-high-contrast-mode-line nil)
;; ;; (setq flatui-use-variable-pitch nil)
;; (setq flatui-scale-org-headlines t)
;; (setq flatui-height-plus-1 1.07)
;; (setq flatui-height-plus-2 1.12)
;; (setq flatui-height-plus-3 1.16)
;; (setq flatui-height-plus-4 1.22)
;; presentation mode:
;; (setq flatui-height-plus-1 1.12)
;; (setq flatui-height-plus-2 1.16)
;; (setq flatui-height-plus-3 1.22)
;; (setq flatui-height-plus-4 1.30)
;; ;; Use high contrast code block header background (or not)
;; (setq flatui-high-contrast-code-block-header t)  ;; not for presentation
;; (load-theme 'flatui-light t)
;; (load-theme 'flatui-dark t)
;;
;; gruvbox
(setq gruvbox-high-contrast-mode-line t)
(setq gruvbox-high-contrast-code-block-header t)
;; (setq gruvbox-use-variable-pitch nil)
(setq gruvbox-scale-org-headlines t)
(setq gruvbox-height-plus-1 1.12)
(setq gruvbox-height-plus-2 1.16)
(setq gruvbox-height-plus-3 1.22)
(setq gruvbox-height-plus-4 1.30)
(load-theme 'gruvbox-dark-medium t)
;;
;; atom-one-dark
;; (load-theme 'atom-one-dark t)
;;
;; spacemacs-theme
;; (load-theme 'spacemacs-dark t)
;; 
;; creamsody
;; (load-theme 'creamsody t)
;; (creamsody-modeline-four)
;;;
;;;;

;;; * theme-changer
;; (setq calendar-location-name "Brixen, It") 
;; (setq calendar-latitude 46.71)
;; (setq calendar-longitude 11.65)
;; (require 'theme-changer)
;; ;; (setq theme-changer-mode "color-theme")
;; ;; (change-theme 'sanityinc-tomorrow-day 'sanityinc-tomorrow-eighties)
;; (change-theme 'doom-nord-light 'doom-nord)
;; ;; (change-theme 'flatui-light 'gruvbox-dark-medium)
;; ;; dark: flatui-dark, gruvbox-dark-medium sanityinc-tomorrow-eighties
;; ;; light: flatui-light, gruvbox-light-hard sanityinc-tomorrow-day

;;; adapt theme to system settings (works only with emacs-plus
(add-hook 'ns-system-appearance-change-functions
          #'(lambda (appearance)
              (mapc #'disable-theme custom-enabled-themes)
              (pcase appearance
                ('light (load-theme 'gruvbox-light-hard t))
                ('dark (load-theme 'gruvbox-dark-medium t)))))
