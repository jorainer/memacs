# My very own personal Emacs configuration

Disclaimer: this is more for my own personal use and I don't expect this
repository to be useful for anybody else.

This repository contains files/settings for my Emacs configuration to simplify
setting up everything after a OS update or similar.

## Emacs

On macOS there are two excellent Emacs versions available which can be easily
installed with [homebrew](https://brew.sh/):
- [emacs-mac](https://github.com/railwaycat/homebrew-emacsmacport),
  (A.K.A. Emacs Mac Port).
- [emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus).

## Packages

Manually copy all files from the `src` directory to `~/.emacs.d/site-list`. All
other packages are installed with `package-install` from ELPA/MELPA/ORG. To
enable the required repositories put this into the `.emacs` file:

```
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)
```

The packages (ideally installed in that order):

- `org-plus-contrib`
- `org-bullets`
- `bibtex-completion`
- `helm`
- `helm-company`
- `helm-bibtex`
- `ess`
- `exec-path-from-shell`
- `markdown-mode`
- `markdown-preview-mode`
- `polymode`
- `poly-markdown`
- `poly-R`
- `magit`
- `imenu-list`
- `editorconfig`
- `autothemer`
- `spaceline`
- `auto-dictionary`
- `fill-column-indicator`


## Themes

To download and install themes change to the *themes* folder and type `make all`
which will download all themes and store them into `~/.emacs.d/themes`.

## Config file

The template config file is [.emacs](.emacs) but it is suggested to adapt this.
