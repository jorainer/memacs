# Makefile to build libraries for plain vanilla emacs

# Copyright (C) 2014 Johannes Rainer

# Author: Johannes Rainer

## Set most variables in Makeconf
include ./Makeconf

# To override ESS variables defined in Makeconf
DESTDIR=${PREFIX}
LISPDIR=${DESTDIR}/site-lisp
ETCDIR=${DESTDIR}/etc
DOCDIR=${DESTDIR}/doc
INFODIR=${DESTDIR}/info

AC=tmp/auto-complete
ARDUINO=tmp/arduino-mode
AUCTEX=src/auctex-11.87
AUTOLANG=tmp/auto-lang
DASH=tmp/dash.el
ESS=tmp/ESS
EXECPATH=tmp/exec-path-from-shell
FUZZY=tmp/fuzzy-el
GITMODE=tmp/git-modes
JULIA=tmp/julia
MAGITSVN=tmp/magit-svn
MAGIT=tmp/magit
OBULLETS=tmp/org-bullets
ORG=tmp/org-mode
ORGACC=tmp/orgmode-accessories
ORGJOURNAL=tmp/org-journal
POPUP=tmp/popup-el
WEATHER=weather-metno-20121023
POLY=tmp/polymode

all : createdirs fetch emacs

# .PHONY : fetch

emacs : core addons

core : createdirs auctex ess org dash execpath poly git-modes magit

addons : createdirs fuzzy popup auto-complete auto-lang other magit-svn org-bullets arduino org-journal

###############
arduino :
	@echo ----- Making Arduino...
#	${EMACS} -Q -L ${ARDUINO} -batch -f batch-byte-compile ${ARDUINO}/*.el
#	mv ${ARDUINO}/*.elc ${LISPDIR}/
	cp ${ARDUINO}/arduino-mode.el ${LISPDIR}/arduino-mode.el
	@echo ----- Done.

auctex :
	@echo ----- Making AUCTeX...
	cd ${AUCTEX} && ./configure --without-texmf-dir --with-lispdir=${LISPDIR} --datarootdir=${DESTDIR} --with-emacs=${EMACS}
	make -C ${AUCTEX}
	make -C ${AUCTEX} install
	@echo ----- Done making AUCTeX

auto-complete : popup
	@echo ----- Making auto-complete from git...
	if [ ! -d ${LISPDIR}/auto-complete ]; then mkdir ${LISPDIR}/auto-complete; fi
	cp ${POPUP}/popup.el ${AC}
	make -C ${AC} byte-compile
#	make -C ${AC} install ${LISPDIR}/auto-complete/
#	${EMACS} -Q -L ${AC} -L ${AC}/lib/popup -L ${AC}/lib/fuzzy -batch -f batch-byte-compile ${AC}/auto-complete.el ${AC}/auto-complete-config.el
	mv ${AC}/*.elc ${LISPDIR}/auto-complete
	cp ${AC}/auto-complete-pkg.el ${LISPDIR}/auto-complete/auto-complete-pkg.el
	if [ ! -d ${LISPDIR}/auto-complete/ac-dict ]; then mkdir ${LISPDIR}/auto-complete/ac-dict; fi
	cp ${AC}/dict/* ${LISPDIR}/auto-complete/ac-dict/
#	${EMACS} -Q -batch -f batch-byte-compile ${AC-GIT}/lib/fuzzy/fuzzy.el ${AC-GIT}/lib/popup/popup.el
#	cp ${AC}/lib/fuzzy/fuzzy.el ${LISPDIR}/auto-complete/
#	cp ${AC}/lib/popup/popup.el ${LISPDIR}/auto-complete/
	@echo ----- Done.

auto-lang :
	@echo ----- making auto-lang
	cp -p ${AUTOLANG}/*.el ${LISPDIR}
	@echo ----- Done.

clean :
	@echo ----- Cleaning...
	rm -Rf tmp/*
	@echo ----- Done.

createdirs :
	@echo ----- creating required dirs...
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${PREFIX} ]; then mkdir ${PREFIX}; fi
	if [ ! -d ${LISPDIR} ]; then mkdir ${LISPDIR}; fi
	if [ ! -d ${DOCDIR} ]; then mkdir ${DOCDIR}; fi
	if [ ! -d ${INFODIR} ]; then mkdir ${INFODIR}; fi
	if [ ! -d ${ETCDIR} ]; then mkdir ${ETCDIR}; fi
	@echo ----- Done.

dash :
	@echo ----- Making dash...
	${EMACS} -Q -L ${DASH} -batch -f batch-byte-compile ${DASH}/*.el
	mv ${DASH}/*.elc ${LISPDIR}/
	@echo ----- Done.

ess :
	@echo ----- Making ESS...
	if [ ! -d ${JULIA} ]; then echo "Need Julia! Call make fetch or make all first!" && exit 1; fi
	rm -df -R -v ${LISPDIR}/ess
	cp ${JULIA}/contrib/julia-mode.el ${ESS}/lisp
	${MAKE} EMACS=${EMACS} -C ${ESS} all
	${MAKE} DESTDIR=${DESTDIR} LISPDIR=${LISPDIR}/ess \
	        ETCDIR=${ETCDIR}/ess DOCDIR=${DOCDIR}/ess \
	        INFODIR=${INFODIR} SITELISP=${LISPDIR} -C ${ESS} install
	@echo ----- Done making ESS

execpath:
	@echo ----- Making exec-path-from-shell
	${EMACS} -Q -L ${EXECPATH} -batch -f batch-byte-compile ${EXECPATH}/*.el
	mv ${EXECPATH}/*.elc ${LISPDIR}/
	@echo ----- Done.

fetch :
	@echo ----- Getting required packages...
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${AC} ]; then cd tmp && git clone https://github.com/auto-complete/auto-complete.git; fi
	cd ${AC} && git pull
	cd ${AC} && git submodule update --init --recursive
#	?auctex?
	if [ ! -d ${AUTOLANG} ]; then cd tmp && git clone https://github.com/altruizine/auto-lang.git; fi
	cd ${AUTOLANG} && git pull
	if [ ! -d ${DASH} ]; then cd tmp && git clone https://github.com/magnars/dash.el.git; fi
	cd ${DASH} && git pull
	if [ ! -d ${ESS} ]; then cd tmp && git clone https://github.com/emacs-ess/ESS; fi
	cd ${ESS} && git pull
	if [ ! -d ${EXECPATH} ]; then cd tmp && git clone https://github.com/purcell/exec-path-from-shell.git; fi
	cd ${EXECPATH} && git pull
	if [ ! -d ${FUZZY} ]; then cd tmp && git clone https://github.com/auto-complete/fuzzy-el.git; fi
	cd ${FUZZY} && git pull
	if [ ! -d ${GITMODE} ]; then cd tmp && git clone https://github.com/magit/git-modes.git; fi
	cd ${GITMODE} && git pull
	if [ ! -d ${MAGIT} ]; then cd tmp && git clone http://github.com/magit/magit; fi
	cd ${MAGIT} && git pull
	if [ ! -d ${MAGITSVN} ]; then cd tmp && git clone http://github.com/magit/magit-svn; fi
	cd ${MAGITSVN} && git pull
	if [ ! -d ${OBULLETS} ]; then cd tmp && git clone https://github.com/sabof/org-bullets.git; fi
	cd ${OBULLETS} && git pull
	if [ ! -d ${ORG} ]; then cd tmp && git clone http://orgmode.org/org-mode.git; fi
	cd ${ORG} && git pull
	if [ ! -d ${ORGACC} ]; then cd tmp && git clone https://github.com/chasberry/orgmode-accessories.git; fi
	cd ${ORGACC} && git pull
	if [ ! -d ${ORGJOURNAL} ]; then cd tmp && git clone https://github.com/bastibe/org-journal.git; fi
	cd ${ORGJOURNAL} && git pull
	if [ ! -d ${POPUP} ]; then cd tmp && git clone https://github.com/auto-complete/popup-el.git; fi
	cd ${POPUP} && git pull
	if [ ! -d ${ARDUINO} ]; then cd tmp && git clone https://github.com/bookest/arduino-mode.git; fi
	cd ${ARDUINO} && git pull
	if [ ! -d ${POLY} ]; then cd tmp && git clone https://github.com/vspinu/polymode.git; fi
	cd ${POLY} && git pull
	if [ ! -d ${JULIA} ]; then cd tmp && git clone https://github.com/JuliaLang/julia.git; fi
	cd ${JULIA} && git pull
#	?weather-metno?

fuzzy:
	@echo ----- Making fuzzy...
	${ELCC} -batch -f batch-byte-compile ${FUZZY}/fuzzy.el
	mv ${FUZZY}/*.elc ${LISPDIR}
	@echo ----- Done.

git-modes:
	@echo ----- Making git-modes...
#	${ELCC} -batch -f batch-byte-compile ${GITMODE}/git-commit-mode.el
#	${ELCC} -batch -f batch-byte-compile ${GITMODE}/git-rebase-mode.el
	${ELCC} -batch -f batch-byte-compile ${GITMODE}/gitconfig-mode.el
	${ELCC} -batch -f batch-byte-compile ${GITMODE}/gitignore-mode.el
	${ELCC} -batch -f batch-byte-compile ${GITMODE}/gitattributes-mode.el
	cp -p ${GITMODE}/*.el ${LISPDIR}
	mv ${GITMODE}/*.elc ${LISPDIR}
	@echo ----- Done.

magit :
	@echo ----- Making magit...
	@echo - Note: if you get an error you might want to install git-modes first.
#	@echo - Note: writing a config.mk file that includes dash...
#	echo "LOAD_PATH = -L lisp -L ../../${DASH}" > ${MAGIT}/config.mk
	if [ ! -e tmp/dash ]; then ln -s dash.el tmp/dash; fi
	${MAKE} EMACS=${EMACS} -C ${MAGIT} all
	rm -df -R -v ${LISPDIR}/magit
	mkdir -p ${LISPDIR}/magit
	cp -p ${MAGIT}/lisp/*.el ${LISPDIR}/magit
	mv ${MAGIT}/lisp/*.elc ${LISPDIR}/magit
	cp -p ${MAGIT}/Documentation/*.info ${INFODIR}/
	@echo ----- Done.

magit-svn:
	@echo ----- Making magit-svn...
#	${ELCC} -batch -f batch-byte-compile ${MAGITSVN}/magit-svn.el
	cp -p ${MAGITSVN}/*.el ${LISPDIR}
#	mv ${MAGITSVN}/*.elc ${LISPDIR}
	@echo ----- Done.

org-bullets :
	@echo ----- Making org-bullets...
	${EMACS} -Q -L ${OBULLETS} -batch -f batch-byte-compile ${OBULLETS}/org-bullets.el
	if [ -e ${APPLISPDIR}/org/org-bullets.el ]; then rm ${APPLISPDIR}/org/org-bullets.el; fi
	mv ${OBULLETS}/*.elc ${APPLISPDIR}/org
	@echo ----- Done.

org-journal :
	@echo ----- Making org-journal...
	${EMACS} -Q -L ${ORGJOURNAL} -batch -f batch-byte-compile ${ORGJOURNAL}/org-journal.el
	if [ -e ${APPLISPDIR}/org/org-journal.el ]; then rm ${APPLISPDIR}/org/org-journal.el; fi
	mv ${ORGJOURNAL}/*.elc ${APPLISPDIR}/org
	@echo ----- Done.

org :
	@echo ----- Making org...
	@echo ----- WARNING! we are over-writing the existing org installation!
	rm -df -R -v ${APPLISPDIR}/org/*
	${MAKE} EMACS=${EMACS} -C ${ORG} all
	${MAKE} EMACS=${EMACS} lispdir=${APPLISPDIR}/org \
	        datadir=${APPETCDIR}/org infodir=${APPINFODIR} -C ${ORG} install
#	if [ ! -d ${APPDOCDIR} ]; then mkdir ${APPDOCDIR}/org; fi
#	cp -p ${ORG}/doc/*.pdf ${APPDOCDIR}/org/
	cp -p -R ${ORG}/contrib/lisp/*.el ${APPLISPDIR}/org/
	@echo ----- Done making org

other :
	@echo ----- compile all .el files...
	if [ ! -d ${LISPDIR} ]; then mkdir ${LISPDIR}; fi
	${ELCC} -batch -f batch-byte-compile src/other/ssh.el
	${ELCC} -batch -f batch-byte-compile src/other/fixpath.el
	${ELCC} -batch -f batch-byte-compile src/other/frame-fns.el
#	${ELCC} -batch -f batch-byte-compile other/frame-cmds.el
	${ELCC} -batch -f batch-byte-compile src/other/framepop.el
	${ELCC} -batch -f batch-byte-compile src/other/import-env-from-shell.el
#	${ELCC} -batch -f batch-byte-compile other/osx-itunes.el
	${ELCC} -batch -f batch-byte-compile src/other/psvn.el
	${ELCC} -batch -f batch-byte-compile src/other/ox-ravel.el
	${ELCC} -batch -f batch-byte-compile src/other/markdown-mode.el
	cp -p src/other/*.el ${LISPDIR}/
	mv src/other/*.elc ${LISPDIR}/
	@echo ----- Done.

poly:
	@echo ----- Making polymode...
#	${EMACS} -Q -L ${POLY} -batch -f batch-byte-compile ${POLY}/*.el
#	${EMACS} -Q -L ${POLY}/modes -batch -f batch-byte-compile ${POLY}/modes/*.el
#	cp -p -R ${POLY}/ ${PREFIX}/site-lisp/polymode
	if [ ! -d ${PREFIX}/site-lisp/polymode ]; then mkdir ${PREFIX}/site-lisp/polymode; fi
	if [ ! -d ${PREFIX}/site-lisp/polymode/modes ]; then mkdir ${PREFIX}/site-lisp/polymode/modes; fi
	cp ${POLY}/*.el ${PREFIX}/site-lisp/polymode
	cp ${POLY}/modes/*.el ${PREFIX}/site-lisp/polymode/modes
	@echo ----- Done.

popup:
	@echo ----- Making popup...
	${ELCC} -batch -f batch-byte-compile ${POPUP}/popup.el
	mv ${POPUP}/*.elc ${LISPDIR}
	@echo ----- Done.

#### Below we have old stuff.


weather-metno :
	@echo ----- Making weather-metno...
#	${EMACS} -batch -f batch-byte-compile ${WEATHER}/*.el
	if [ ! -d ${PREFIX}/site-lisp/weather-metno ]; then mkdir ${PREFIX}/site-lisp/weather-metno; fi
	cp -p -R ${WEATHER}/ ${PREFIX}/site-lisp/weather-metno
	@echo ----- Done.

## copy the ox-ravel.el export module. Note: ideally this should first
## update the code with svn, then tangle the ox-ravel.org which generates
## the .el file and then copy the file.
ravel :
	@echo ----- Generating ox-ravel.el
	cp -p ${RAVEL}/ox-ravel.el ${PREFIX}/site-lisp/
	@echo ----- Done.



