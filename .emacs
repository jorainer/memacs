;; that's a cleaned version of the .emacs for a "vanilla" Emacs
;; We're adding our own set of of extensions and are in addition
;; overwriting the org-mode that comes with Emacs.

;;(package-initialize)

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
;; (set-default-font "Inconsolata-dz for Powerline")
;; (add-to-list 'default-frame-alist '(font . "Inconsolata-dz for Powerline-13"))
;; (set-face-attribute 'default t :font "Inconsolata-dz for Powerline-13")
;; (set-default-font "-*-Inconsolata-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'default nil :font "-*-Inconsolata-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'default nil :font "-*-Inconsolata-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;; have to set the following two, in order to
;;(set-face-attribute 'fixed-pitch nil :font "-*-Inconsolata-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")
;;(set-face-attribute 'variable-pitch nil :font "-*-Inconsolata-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")

;; Source Code Pro
;; (set-default-font "Source Code Pro for Powerline")
;; (add-to-list 'default-frame-alist '(font . "Source Code Pro for Powerline-12"))
;; (set-face-attribute 'default t :font "Source Code Pro for Powerline-12")

;; Apple SF font
;; (set-default-font "SF Mono")
;; (add-to-list 'default-frame-alist '(font . "SF Mono-14"))
;; (set-face-attribute 'default t :font "SF Mono-14")
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
	(concat ":~/bin:/usr/local/bin:/usr/bin:/bin"
	(getenv "PATH"))
	)

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
 '(custom-safe-themes
   (quote
    ("7f407534aa429959f17e4d48a57c7b7c50a5c888e76cd13acae3907076d5ca72" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "781fdddfda7b27fbdc9a67c502496db0c34e48ea49d0cece3612c6cba0d89451" "809cd3e553d4a7150794c7cc7ddaf6b74f835aa0b21786b8ddfe35f837761013" "ed317c0a3387be628a48c4bbdb316b4fa645a414838149069210b66dd521733f" "da0468f37373855e845e7ebfd7cdc334e0ea92de4dcf6695a4eefd1dc884410d" "c924950f6b5b92a064c5ad7063bb34fd3facead47cd0d761a31e7e76252996f7" "d793919bc252952ebea0cdfaa2241b8a5e83f581123f7752f1c68554a2c867fd" "34af76ab5d1369a18a77174c3b8a450820900211d92106aa846a7853f8c16440" "5eb44a5d38e3c273d8a10bb03fac0ad4533debd39819b8a7a2ba283a52cf4527" "86446384ca324dd3154d71fe97894dfb5d046913ae43aa4ffabd8228794f0fa1" "449c37535e8713dd431496870595f998c5c1b8075319843b7336707749ffef1d" "283ec00760b8fedc4add974c22846dda6235d5fbce59c9446940686bf0ebe5b4" "c0dd134ecd6ede6508c30f7d4ac92334229531df62284fc6572f65b4d0cde43f" "da74e98149367c52e54949a324d80cad17807083fb88c6af318330a91fbccd90" "aa085c92f21f5aef333a4e26980331d0b5f2bae7c4053558a90ed7229f165139" "2e635a764137174fc9fedb7cf700848ce7fea482cc26f9b87b09272d499860da" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "5f8018b6f2e39e6de7d38fc5677d47e68aedbb18efe3660aa8043bc8784fb5af" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "2acad40240f9de1d74378f49c74d8ff03d0499bdbced4b1a79692e9cb298d3f9" default)))
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;
;;;;


;;; * Themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Themes, load with "M-x load-theme"
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
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
;;(setq gruvbox-high-contrast-mode-line t)
;; (setq gruvbox-high-contrast-code-block-header t)
;;(setq gruvbox-use-variable-pitch nil)
;; (setq gruvbox-scale-org-headlines t)
;; (setq gruvbox-height-plus-1 1.07)
;; (setq gruvbox-height-plus-2 1.12)
;; (setq gruvbox-height-plus-3 1.16)
;; (setq gruvbox-height-plus-4 1.22)
;; (load-theme 'gruvbox-dark t)
;;
;; atom-one-dark
;; (load-theme 'atom-one-dark t)
;;
;; creamsody
(load-theme 'creamsody t)
(creamsody-modeline-four)
;;
;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Packages and stuff


;;; * AUCTex
;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; AUCTex
;;
;; path where auctex has been installed...
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(load "auctex.el" nil t t)
;; Add standard Sweave file extensions to the list of files recognized
;; by AUCTeX.
(setq TeX-file-extensions
      '("Rnw" "rnw" "Snw" "snw" "tex" "sty" "cls" "ltx" "texi" "texinfo" "dtx"))
;;
;;;;

;;; * company-mode
;;;;;;;;;;;;;;;;;;;;;;;
;;
;; company-mode
;; (load "company.el")
;; Config comes from https://github.com/izahn/dotemacs/blob/master/init.el
(require 'company)
;; cancel if input doesn't match, be patient, and don't complete automatically.
;; set company-idle-delay nil for no automatic matching.
(setq company-require-match nil
      company-async-timeout 6
      company-idle-delay 1)
;; complete using C-tab
;; (global-set-key (kbd "<C-tab>") 'counsel-company)
;; use C-n and C-p to cycle through completions
;; (define-key company-mode-map (kbd "<C-tab>") 'company-complete)
;; (define-key company-active-map (kbd "C-n") 'company-select-next)
;; (define-key company-active-map (kbd "<tab>") 'company-complete-common)
;; (define-key company-active-map (kbd "C-p") 'company-select-previous)
;; (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
;;
(require 'company-capf)
;; put company-capf and company-files at the beginning of the list
;; (setq company-backends
;;       '(company-files company-capf company-nxml company-css company-cmake company-semantic company-clang company-xcode company-eclim))
;; (setq-default company-backends
;;               '(company-files company-capf company-nxml company-css company-cmake company-semantic company-clang company-xcode company-eclim))
;; put company-capf and company-files at the beginning of the list
(setq company-backends
      '(company-files company-capf company-gtags company-ispell company-nxml company-css company-cmake company-semantic))
(setq-default company-backends
              '(company-files company-capf company-gtags company-ispell company-nxml company-css company-cmake company-semantic))
;;
(defun my-company-indent-or-complete-common ()
  "Indent the current line or region, or complete the common part."
  (interactive)
  (cond
   ((use-region-p)
    (indent-region (region-beginning) (region-end)))
   ((and (not (looking-at "\\w\\|\\s_"))
         (memq indent-line-function
               '(indent-relative indent-relative-maybe)))
    (company-complete-common))
   ((let ((old-point (point))
          (old-tick (buffer-chars-modified-tick))
          (tab-always-indent t))
      (call-interactively #'indent-for-tab-command)
      (when (and (eq old-point (point))
                 (eq old-tick (buffer-chars-modified-tick))
                 (not (looking-at "\\w\\|\\s_")))
        (company-complete-common))))))

;; (define-key company-mode-map (kbd "<tab>") 'my-company-indent-or-complete-common)
;;
(add-hook 'after-init-hook 'global-company-mode)
;;
;;;;

;;; * helm-complete
;;;;;;;;;;;;;;;;;;;;;;;
;;
;; helm-complete
(autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))
;; (global-set-key "\t" 'helm-company)
(define-key company-mode-map (kbd "<C-tab>") 'helm-company)
;;
;;;;

;;; * ESS
;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ESS
;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/ess")
;; (load "ess-site")
(require 'ess-site)
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
;;? (setq eldoc-echo-area-use-multiline-p t)
;; Don't use a R history file.
(setq ess-history-file nil)
;; Uncomment below if we're getting problems doing an ediff on an R-file with magit. merge conflict
;;(add-to-list 'auto-mode-alist '("\\.R" . ess-mode))
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
;;
;; Code indenting etc.
;; (add-hook 'ess-mode-hook
;;           (lambda ()
;;             (ess-set-style 'C++ 'quiet)
;;             ;; Because
;;             ;;                                 DEF GNU BSD K&R C++
;;             ;; ess-indent-level                  2   2   8   5   4
;;             ;; ess-continued-statement-offset    2   2   8   5   4
;;             ;; ess-brace-offset                  0   0  -8  -5  -4
;;             ;; ess-arg-function-offset           2   4   0   0   0
;;             ;; ess-expression-offset             4   2   8   5   4
;;             ;; ess-else-offset                   0   0   0   0   0
;;             ;; ess-close-brace-offset            0   0   0   0   0
;;             (add-hook 'local-write-file-hooks
;;                       (lambda ()
;;                         (ess-nuke-trailing-whitespace)))))
;; (setq ess-nuke-trailing-whitespace-p 'ask)
;; (setq c-default-style "bsd"
;;       c-basic-offset 4)
;;
;;;;


;;; * tramp
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
(add-to-list 'load-path "~/.emacs.d/site-lisp/org")
;; (require 'ess-site)
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
;;(require 'ox-bibtex)
;2(require 'org-eval)
;; enable fontify:
;2(setq org-src-fontify-natively t)
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
       '((sequence "TODO(t)" "WAIT(w@/!)" "VERIFY(v@)" "REDO(r@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(setq org-todo-keyword-faces
;	'(("TODO" . (:foreground "DeepPink1" :weight bold :slant italic :underline t))
	'(("TODO" . (:foreground "#f39c12" :weight bold :slant italic :underline t))
	("WAIT" . (:foreground "#3498db" :slant italic :underline t))
	("DONE" . (:foreground "#27ae60" :slant italic :undeline t))
	("CANCELED" . (:foreground "#9b59b6" :weight bold :slant italic :underline t))
	("REDO" . (:foreground "#e74c3c" :weight bold :slant italic :underline t))
	("VERIFY" . (:foreground "#e74c3c" :weight bold :slant italic :underline t))
	))
;; we don't want to always say "yes" please execute code...
(setq org-confirm-babel-evaluate nil)
;; define a org-to-latex template
;;(setq org-export-latex-listings t)
;;(setq org-export-latex-listings 'minted)

(setq org-latex-listings 'minted)
;(setq org-latex-custom-lang-environments
;       '(
;	(R "Rcode")
;	))

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
;; these custom agenda views will be displayed in the org-mobile app
(setq org-tag-alist '(("analysis" . ?n) ("ageing" . ?A) ("collab" . ?c) ("EURAC" . ?E)
		      ("EURA-K" . ?K) ("noexport" . ?N) ("paper" . ?a) ("private" . ?p)
		      ("project" . ?P) ("review" . ?r) ("work" . ?w) ))
(setq org-agenda-custom-commands
      '(("p" "Private TODOs"
	 ((tags-todo "private")
	  ))
	("w" "Work related TODOs"
	 (
	  (tags-todo "work+analysis")
	  (tags-todo "work+project")
	  (tags-todo "work+paper")
	  (tags-todo "work+collab")
	  (tags-todo "work-analysis-project-paper-collab")
	  ))
	))
;; org-export settings:
;; allows to define a init file other than the default one, specifically
;; useful if async export yields e.g. an error complaining that the font
;; can not be found.
(setq org-export-async-init-file "/Users/jo/.emacs-async-init.el")
;; try this for gplots evaluation
(setq org-babel-use-quick-and-dirty-noweb-expansion t)
;; org-journal settings:
;2(require 'org-journal)
;2(setq org-journal-dir "/Users/jo/org-files/journal/")
;2(global-set-key (kbd "C-c C-n") 'org-journal-new-entry)
;;
;; For update to orgmode 9.0
(defun org-repair-export-blocks ()
  "Repair export blocks and INCLUDE keywords in current buffer."
  (interactive)
  (when (eq major-mode 'org-mode)
    (let ((case-fold-search t)
          (back-end-re (regexp-opt
                        '("HTML" "ASCII" "LATEX" "ODT" "MARKDOWN" "MD" "ORG"
                          "MAN" "BEAMER" "TEXINFO" "GROFF" "KOMA-LETTER")
                        t)))
      (org-with-wide-buffer
       (goto-char (point-min))
       (let ((block-re (concat "^[ \t]*#\\+BEGIN_" back-end-re)))
         (save-excursion
           (while (re-search-forward block-re nil t)
             (let ((element (save-match-data (org-element-at-point))))
               (when (eq (org-element-type element) 'special-block)
                 (save-excursion
                   (goto-char (org-element-property :end element))
                   (save-match-data (search-backward "_"))
                   (forward-char)
                   (insert "EXPORT")
                   (delete-region (point) (line-end-position)))
                 (replace-match "EXPORT \\1" nil nil nil 1))))))
       (let ((include-re
              (format "^[ \t]*#\\+INCLUDE: .*?%s[ \t]*$" back-end-re)))
         (while (re-search-forward include-re nil t)
           (let ((element (save-match-data (org-element-at-point))))
             (when (and (eq (org-element-type element) 'keyword)
                        (string= (org-element-property :key element) "INCLUDE"))
               (replace-match "EXPORT \\1" nil nil nil 1)))))))))
;;
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
;;(autoload 'gfm-mode "markdown-mode"
;;   "Major mode for editing GitHub Flavored Markdown files" t)
;;(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

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
;;(require 'poly-C)
;; (require 'poly-slim)
;; (require 'poly-erb)
;;(require 'poly-org)

;;; * magit
;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit, git control
;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit")
(require 'magit)
;; (require 'magit-svn)
(setq magit-repo-dirs-depth 4)
;;
;;;;

;;; * magithub
;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit + github
;;
(require 'magithub)
(setq magithub-feature-autoinject t)
;;
;;;;

;;; * ox-ravel
;;;;
;; the ox-ravel Sweave export module
(require 'ox-ravel)
;;
;;;;

;;; * ssh
;;;;;;;;;;;;;;;;;;;;;;;;;
;; ssh
;;
(require 'ssh)
(setq ssh-display-follow-current-frame t)
(setq ssh-explicit-args '("-Y"))
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

;;; ** auto-lang
;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-lang to automatically set the language for ispell.
;;
(require 'auto-lang)
(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)
;;
;;;;


;;; * Other sorted and unsorted settings
;;; ** zoom-frame
(require 'zoom-frm)
(global-set-key (kbd "C-x C-+") 'zoom-in)
(global-set-key (kbd "C-x C--") 'zoom-out)

;;; ** org-ioslide
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/org-ioslide")
;; (require 'ox-ioslide)

;;; ** org-tree-slide
;; (require 'org-tree-slide)
;; (global-set-key (kbd "<f9>") 'org-tree-slide-mode)
;; (global-set-key (kbd "S-<f9>") 'org-tree-slide-skip-done-toggle)

;;; ** epresent
;; (require 'epresent)
;; (global-set-key (kbd "<f6>") 'epresent-run)

;;; ** arduino
;; (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
;; (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

;;; ** perl
(defalias 'perl-mode 'cperl-mode)

;; ;;; ** psvn and framepop
;; (add-to-list 'vc-handled-backends 'SVN)
;; (require 'psvn)
;; (require 'framepop)

;;; ** TAGS
;; (visit-tags-table "~/Projects/git/TAGS")
;; (setq tags-table-list
;;       '("~/Projects/git/"))

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

;;; ** helm
(add-to-list 'load-path "~/.emacs.d/site-lisp/helm")
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
;;

;;;;
;; eimp
(require 'eimp)
(add-hook 'image-mode-hook 'eimp-mode)
;; (kbd "+") 'eimp-increase-image-size
;; (kbd "-") 'eimp-decrease-image-size
;; (kbd "<") 'eimp-rotate-image-anticlockwise
;; (kbd ">") 'eimp-rotate-image-clockwise
;; (kbd "B +") 'eimp-blur-image
;; (kbd "B -") 'eimp-sharpen-image
;; (kbd "B E") 'eimp-emboss-image
;; (kbd "B G") 'eimp-gaussian-blur-image
;; (kbd "B R") 'eimp-radial-blur-image
;; (kbd "C B +") 'eimp-increase-image-brightness
;; (kbd "C B -") 'eimp-decrease-image-brightness
;; (kbd "C C +") 'eimp-increase-image-contrast
;; (kbd "C C -") 'eimp-decrease-image-contrast
;; (kbd "F ^") 'eimp-flip-image
;; (kbd "F >") 'eimp-flop-image
;; (kbd "F <") 'eimp-flop-image
;; (kbd "N") 'eimp-negate-image

;; ; Commands most relevant to you:
;; (kbd "S f") 'eimp-fit-image-to-window
;; (kbd "S h") 'eimp-fit-image-height-to-window
;; (kbd "S w") 'eimp-fit-image-width-to-window

;; (kbd "<right>") 'eimp-roll-image-right
;; (kbd "<left>") 'eimp-roll-image-left
;; (kbd "<up>") 'eimp-roll-image-up
;; (kbd "<down>") 'eimp-roll-image-down
;; (kbd "<down-mouse-1>") 'eimp-mouse-resize-image
;; (kbd "<S-down-mouse-1>") 'eimp-mouse-resize-image-preserve-aspect
;; (kbd "C-c C-k") 'eimp-stop-all

;; ;;;;
;; ;; windmove
;; (global-set-key (kbd "C-c <left>") 'windmove-left)
;; (global-set-key (kbd "C-c <right>") 'windmove-right)
;; (global-set-key (kbd "C-c <up>") 'windmove-up)
;; (global-set-key (kbd "C-c <down>") 'windmove-down)

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

;; (require 'macbook-keyboard-fix)

