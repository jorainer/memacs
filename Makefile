# Makefile to build libraries for plain vanilla emacs

# Copyright (C) 2016 Johannes Rainer

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
APIWRAP=tmp/apiwrap.el
AUTOTHEMER=tmp/autothemer
COMPMODE=tmp/company-mode
ARDUINO=tmp/arduino-mode
AUCTEX=src/auctex-11.87
AUTOLANG=tmp/auto-lang
ASYNC=tmp/emacs-async
DASH=tmp/dash.el
EDITORCONF=tmp/editorconfig-emacs
ESS=tmp/ESS
EXECPATH=tmp/exec-path-from-shell
EPRESENT=tmp/epresent
F=tmp/f.el
FCI=tmp/Fill-Column-Indicator
FUZZY=tmp/fuzzy-el
GITMODE=tmp/git-modes
GHUB=tmp/ghub
GHUBPLUS=tmp/ghub-plus
GRAPHQL=tmp/graphql.el
HELM=tmp/helm
HELMCOMP=tmp/helm-company
HYDRA=tmp/hydra
ILIST=tmp/imenu-list
IOSLIDE=tmp/org-ioslide
JULIA=tmp/julia
JEMACS=tmp/julia-emacs
MAGITSVN=tmp/magit-svn
MAGIT=tmp/magit
MAGITHUB=tmp/magithub
MAGITPOPUP=tmp/magit-popup
MD=tmp/markdown-mode
MF=tmp/macbook-keyboard-fix.el
NYANMODE=tmp/nyan-mode
OBULLETS=tmp/org-bullets
ORG=tmp/org-mode
ORGACC=tmp/orgmode-accessories
ORGJOURNAL=tmp/org-journal
ORGTREESLIDE=tmp/org-tree-slide
OS=tmp/org-sync
POLY=tmp/polymode
POLYR=tmp/poly-R
POLYMARK=tmp/poly-markdown
POLYORG=tmp/poly-org
POLYNW=tmp/poly-noweb
POPUP=tmp/popup-el
POWERLINE=tmp/powerline
S=tmp/s.el
SPACELINE=tmp/spaceline
THEMECHANGER=tmp/theme-changer
TRANSIENT=tmp/transient
TREEPY=tmp/treepy.el
WEATHER=weather-metno-20121023
WITHED=tmp/with-editor

all : createdirs fetch emacs

# .PHONY : fetch

emacs : core addons

core : createdirs auctex org-async org dash execpath md poly treepy graphql hydra git-modes with-editor ghub apiwrap ghub-plus transient fci ilist editorconfig

addons : createdirs fuzzy popup company-mode helm-company auto-lang other org-bullets arduino ravel org-journal s f ioslide org-tree-slide epresent org-sync async helm powerline autothemer macfix spaceline nyan-mode theme-changer julia-emacs

###############
arduino :
	@echo ----- Making Arduino...
	cp ${ARDUINO}/arduino-mode.el ${LISPDIR}/arduino-mode.el
	@echo ----- Done.

apiwrap :
	@echo ----- Making apiwrap...
	cp ${APIWRAP}/apiwrap.el ${LISPDIR}/apiwrap.el
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
	mv ${AC}/*.elc ${LISPDIR}/auto-complete
	cp ${AC}/auto-complete-pkg.el ${LISPDIR}/auto-complete/auto-complete-pkg.el
	if [ ! -d ${LISPDIR}/auto-complete/ac-dict ]; then mkdir ${LISPDIR}/auto-complete/ac-dict; fi
	cp ${AC}/dict/* ${LISPDIR}/auto-complete/ac-dict/
	@echo ----- Done.

auto-lang :
	@echo ----- making auto-lang
	cp -p ${AUTOLANG}/*.el ${LISPDIR}
	@echo ----- Done.

autothemer :
	@echo ----- making autothemer
	cp -p ${AUTOTHEMER}/*.el ${LISPDIR}
	@echo ----- Done.

async :
	@echo ----- making async
	cp -p ${ASYNC}/*.el ${LISPDIR}
	@echo ----- Done.

clean :
	@echo ----- Cleaning...
	rm -Rf tmp/*
	@echo ----- Done.

company-mode :
	@echo ----- making company mode
	cp ${COMPMODE}/*.el ${LISPDIR}
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
	cd ${ESS} && make clean distclean
	cd ${ESS} && git checkout ${ess_release}
# cp ${JULIA}/contrib/julia-mode.el ${ESS}/lisp
#	${MAKE} EMACS=${EMACS} -C ${ESS} all
	${MAKE} EMACS=${EMACS} -C ${ESS} lisp
	${MAKE} DESTDIR=${DESTDIR} LISPDIR=${LISPDIR}/ess \
	        ETCDIR=${ETCDIR}/ess DOCDIR=${DOCDIR}/ess \
	        INFODIR=${INFODIR} SITELISP=${LISPDIR} -C ${ESS} install
	cd ${ESS} && make clean distclean
#	cd ${ESS} && git checkout master
	@echo ----- Done making ESS

editorconfig:
	@echo ----- Making editorconfig
	cp ${EDITORCONF}/*.el ${LISPDIR}
	@echo ----- Done.

epresent:
	@echo ----- Making epresent
	cp ${EPRESENT}/*.el ${LISPDIR}
	@echo ----- Done.

execpath:
	@echo ----- Making exec-path-from-shell
	${EMACS} -Q -L ${EXECPATH} -batch -f batch-byte-compile ${EXECPATH}/*.el
	mv ${EXECPATH}/*.elc ${LISPDIR}/
	@echo ----- Done.

f:
	@echo ----- Making f
	cp ${F}/f.el ${LISPDIR}
	@echo ----- Done.

fetch :
	@echo ----- Getting required packages...
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${AC} ]; then cd tmp && git clone https://github.com/auto-complete/auto-complete.git; fi
	cd ${AC} && git pull
	cd ${AC} && git submodule update --init --recursive
#	?auctex?
	if [ ! -d ${APIWRAP} ]; then cd tmp && git clone https://github.com/vermiculus/apiwrap.el; fi
	cd ${APIWRAP} && git pull
	if [ ! -d ${AUTOLANG} ]; then cd tmp && git clone https://github.com/altruizine/auto-lang.git; fi
	cd ${AUTOLANG} && git pull
	if [ ! -d ${AUTOTHEMER} ]; then cd tmp && git clone https://github.com/sebastiansturm/autothemer.git; fi
	cd ${AUTOTHEMER} && git pull
	if [ ! -d ${ASYNC} ]; then cd tmp && git clone https://github.com/jwiegley/emacs-async.git; fi
	cd ${ASYNC} && git pull
	if [ ! -d ${COMPMODE} ]; then cd tmp && git clone https://github.com/company-mode/company-mode.git; fi
	cd ${COMPMODE} && git pull
	if [ ! -d ${DASH} ]; then cd tmp && git clone https://github.com/magnars/dash.el.git; fi
	cd ${DASH} && git pull
	if [ ! -d ${EDITORCONF} ]; then cd tmp && git clone https://github.com/editorconfig/editorconfig-emacs; fi
	cd ${EDITORCONF} && git pull
	# if [ ! -d ${ESS} ]; then cd tmp && git clone --depth 300 https://github.com/emacs-ess/ESS; fi
	# cd ${ESS} && git checkout master && git pull
	if [ ! -d ${EPRESENT} ]; then cd tmp && git clone https://github.com/eschulte/epresent.git; fi
	cd ${EPRESENT} && git pull
	if [ ! -d ${EXECPATH} ]; then cd tmp && git clone https://github.com/purcell/exec-path-from-shell.git; fi
	cd ${EXECPATH} && git pull
	if [ ! -d ${F} ]; then cd tmp && git clone https://github.com/rejeep/f.el.git; fi
	cd ${F} && git pull
	if [ ! -d ${FCI} ]; then cd tmp && git clone https://github.com/jorainer/Fill-Column-Indicator.git; fi
	cd ${FCI} && git pull
	if [ ! -d ${FUZZY} ]; then cd tmp && git clone https://github.com/auto-complete/fuzzy-el.git; fi
	cd ${FUZZY} && git pull
	if [ ! -d ${GITMODE} ]; then cd tmp && git clone https://github.com/magit/git-modes.git; fi
	cd ${GITMODE} && git pull
	if [ ! -d ${GHUB} ]; then cd tmp && git clone https://github.com/magit/ghub; fi
	cd ${GHUB} && git pull
	if [ ! -d ${GHUBPLUS} ]; then cd tmp && git clone https://github.com/vermiculus/ghub-plus; fi
	cd ${GHUBPLUS} && git pull
	if [ ! -d ${GRAPHQL} ]; then cd tmp && git clone https://github.com/vermiculus/graphql.el; fi
	cd ${GRAPHQL} && git pull
	if [ ! -d ${ILIST} ]; then cd tmp && git clone https://github.com/bmag/imenu-list.git; fi
	cd ${ILIST} && git pull
	if [ ! -d ${IOSLIDE} ]; then cd tmp && git clone https://github.com/coldnew/org-ioslide.git; fi
	cd ${IOSLIDE} && git pull
	if [ ! -d ${HELM} ]; then cd tmp && git clone https://github.com/emacs-helm/helm.git; fi
	cd ${HELM} && git pull
	if [ ! -d ${HELMCOMP} ]; then cd tmp && git clone https://github.com/Sodel-the-Vociferous/helm-company.git; fi
	cd ${HELMCOMP} && git pull
	if [ ! -d ${HYDRA} ]; then cd tmp && git clone https://github.com/abo-abo/hydra; fi
	cd ${HYDRA} && git pull
	if [ ! -d ${MAGIT} ]; then cd tmp && git clone http://github.com/magit/magit; fi
	cd ${MAGIT} && git pull
	if [ ! -d ${MAGITPOPUP} ]; then cd tmp && git clone https://github.com/magit/magit-popup.git; fi
	cd ${MAGITPOPUP} && git pull
	if [ ! -d ${MAGITSVN} ]; then cd tmp && git clone http://github.com/magit/magit-svn; fi
	cd ${MAGITSVN} && git pull
	if [ ! -d ${MD} ]; then cd tmp && git clone https://github.com/jrblevin/markdown-mode.git; fi
	cd ${MD} && git checkout master && git pull
	if [ ! -d ${MF} ]; then cd tmp && git clone https://github.com/jorainer/macbook-keyboard-fix.el; fi
	cd ${MF} && git pull
	if [ ! -d ${MAGITHUB} ]; then cd tmp && git clone https://github.com/vermiculus/magithub.git; fi
	cd ${MAGITHUB} && git pull
	if [ ! -d ${NYANMODE} ]; then cd tmp && git clone https://github.com/TeMPOraL/nyan-mode; fi
	cd ${NYANMODE} && git pull
	if [ ! -d ${OBULLETS} ]; then cd tmp && git clone https://github.com/sabof/org-bullets.git; fi
	cd ${OBULLETS} && git pull
	if [ ! -d ${ORG} ]; then cd tmp && git clone https://code.orgmode.org/bzg/org-mode.git; fi
	cd ${ORG} && git checkout master && git pull
	if [ ! -d ${ORGTREESLIDE} ]; then cd tmp && git clone https://github.com/takaxp/org-tree-slide.git; fi
	cd ${ORGTREESLIDE} && git pull
	if [ ! -d ${ORGACC} ]; then cd tmp && git clone https://github.com/chasberry/orgmode-accessories.git; fi
	cd ${ORGACC} && git pull
	if [ ! -d ${ORGJOURNAL} ]; then cd tmp && git clone https://github.com/bastibe/org-journal.git; fi
	cd ${ORGJOURNAL} && git pull
	if [ ! -d ${OS} ]; then cd tmp && git clone https://github.com/arbox/org-sync.git; fi
	cd ${OS} && git pull
	if [ ! -d ${POPUP} ]; then cd tmp && git clone https://github.com/auto-complete/popup-el.git; fi
	cd ${POPUP} && git pull
	if [ ! -d ${POWERLINE} ]; then cd tmp && git clone https://github.com/milkypostman/powerline.git; fi
	cd ${POWERLINE} && git pull
	if [ ! -d ${ARDUINO} ]; then cd tmp && git clone https://github.com/bookest/arduino-mode.git; fi
	cd ${ARDUINO} && git pull
	if [ ! -d ${POLY} ]; then cd tmp && git clone https://github.com/polymode/polymode.git; fi
	cd ${POLY} && git checkout master && git pull
	if [ ! -d ${POLYR} ]; then cd tmp && git clone https://github.com/polymode/poly-R; fi
	cd ${POLYR} && git checkout master && git pull
	if [ ! -d ${POLYMARK} ]; then cd tmp && git clone https://github.com/polymode/poly-markdown; fi
	cd ${POLYMARK} && git checkout master && git pull
	if [ ! -d ${POLYORG} ]; then cd tmp && git clone https://github.com/polymode/poly-org; fi
	cd ${POLYORG} && git checkout master && git pull
	if [ ! -d ${POLYNW} ]; then cd tmp && git clone https://github.com/polymode/poly-noweb; fi
	cd ${POLYNW} && git checkout master && git pull
	if [ ! -d ${JULIA} ]; then cd tmp && git clone https://github.com/JuliaLang/julia.git; fi
	cd ${JULIA} && git pull
	if [ ! -d ${JEMACS} ]; then cd tmp && git clone https://github.com/JuliaEditorSupport/julia-emacs; fi
	cd ${JEMACS} && git pull
	if [ ! -d ${S} ]; then cd tmp && git clone https://github.com/magnars/s.el.git; fi
	cd ${S} && git pull
	if [ ! -d ${SPACELINE} ]; then cd tmp && git clone https://github.com/TheBB/spaceline; fi
	cd ${SPACELINE} && git pull
	if [ ! -d ${THEMECHANGER} ]; then cd tmp && git clone https://github.com/hadronzoo/theme-changer; fi
	cd ${THEMECHANGER} && git pull
	if [ ! -d ${TRANSIENT} ]; then cd tmp && git clone https://github.com/magit/transient; fi
	cd ${TRANSIENT} && git pull
	if [ ! -d ${TREEPY} ]; then cd tmp && git clone https://github.com/volrath/treepy.el; fi
	cd ${TREEPY} && git pull
	if [ ! -d ${WITHED} ]; then cd tmp && git clone https://github.com/magit/with-editor.git; fi
	cd ${WITHED} && git pull
#	?weather-metno?

fci:
	@echo ----- Making Fill-Column-Indicator...
	${ELCC} -f batch-byte-compile ${FCI}/fill-column-indicator.el
	mv ${FCI}/*.elc ${LISPDIR}
	@echo ----- Done.

fuzzy:
	@echo ----- Making fuzzy...
	${ELCC} -f batch-byte-compile ${FUZZY}/fuzzy.el
	if [ ! -d ${LISPDIR}/helm ]; then mkdir ${LISPDIR}/helm; fi
	mv ${FUZZY}/*.elc ${LISPDIR}/helm
	@echo ----- Done.

git-modes:
	@echo ----- Making git-modes...
	${ELCC} -f batch-byte-compile ${GITMODE}/gitconfig-mode.el
	${ELCC} -f batch-byte-compile ${GITMODE}/gitignore-mode.el
	${ELCC} -f batch-byte-compile ${GITMODE}/gitattributes-mode.el
	cp -p ${GITMODE}/*.el ${LISPDIR}
	mv ${GITMODE}/*.elc ${LISPDIR}
	@echo ----- Done.

ghub :
	@echo ----- making ghub
	cp -p ${GHUB}/*.el ${LISPDIR}
	@echo ----- Done.

ghub-plus :
	@echo ----- making ghub-plus
	cp -p ${GHUBPLUS}/*.el ${LISPDIR}
	@echo ----- Done.

graphql :
	@echo ----- making graphql
	cp -p ${GRAPHQL}/*.el ${LISPDIR}
	@echo ----- Done.

helm:
	@echo ----- Making helm...
	${MAKE} EMACS=${EMACS} -C ${HELM} all
	rm -df -R -v ${LISPDIR}/helm
	mkdir -p ${LISPDIR}/helm
##	mv ${HELM}/*.elc ${LISPDIR}/helm
	cp -p ${HELM}/*.el ${LISPDIR}/helm
	@echo ----- Done.

helm-company:
	@echo ----- Making helm-company...
	cp -p ${HELMCOMP}/*.el ${LISPDIR}
	@echo ----- Done.

hydra:
	@echo ----- Making hydra...
	cp -p ${HYDRA}/*.el ${LISPDIR}
	@echo ----- Done.

ilist:
	@echo ----- Making imenu-list...
	cp -p ${ILIST}/*.el ${LISPDIR}
	@echo ----- Done.

ioslide:
	@echo ----- Making ioslide...
	if [ ! -d ${PREFIX}/site-lisp/org-ioslide ]; then mkdir ${PREFIX}/site-lisp/org-ioslide; fi
	cp -r ${IOSLIDE}/* ${PREFIX}/site-lisp/org-ioslide
	@echo ----- Done.

julia-emacs:
	@echo ----- Making julia-emacs...
	cp -r ${JEMACS}/*.el ${LISPDIR}
	@echo ----- Done.

magit :
	@echo ----- Making magit...
	@echo - Note: if you get an error you might want to install git-modes first.
	if [ ! -e tmp/dash ]; then ln -s dash.el tmp/dash; fi
	if [ ! -e tmp/graphql ]; then ln -s graphql.el tmp/graphql; fi
	if [ ! -e tmp/treepy ]; then ln -s treepy.el tmp/treepy; fi
	${MAKE} EMACS=${EMACS} -C ${MAGIT} all
	rm -df -R -v ${LISPDIR}/magit
	mkdir -p ${LISPDIR}/magit
	cp -p ${MAGIT}/lisp/*.el ${LISPDIR}/magit
	mv ${MAGIT}/lisp/*.elc ${LISPDIR}/magit
	cp -p ${MAGIT}/Documentation/*.info ${INFODIR}/
	@echo ----- Done.

magit-svn:
	@echo ----- Making magit-svn...
	cp -p ${MAGITSVN}/*.el ${LISPDIR}
	@echo ----- Done.

magithub:
	@echo ----- Making magithub...
	cp -p ${MAGITHUB}/*.el ${LISPDIR}
	@echo ----- Done.

magit-popup:
	@echo ----- Making magit-popup...
	cp -p ${MAGITPOPUP}/*.el ${LISPDIR}
	@echo ----- Done.

md:
	@echo ----- Making markdown-mode...
	cd ${MD} && git checkout ${markdown_release}
	${ELCC} -f batch-byte-compile ${MD}/markdown-mode.el
	mv ${MD}/*.elc ${LISPDIR}
	@echo ----- Done.

macfix:
	@echo ----- Making macbook-keyboard-fix...
	${ELCC} -f batch-byte-compile ${MF}/macbook-keyboard-fix.el
	mv ${MF}/*.elc ${LISPDIR}
	@echo ----- Done.

nyan-mode:
	@echo ----- Making nyan-mode...
	cp -r ${NYANMODE}/*.el ${LISPDIR}
	@echo ----- Done.

org-tree-slide:
	@echo ----- Making org-tree-slide...
	cp -r ${ORGTREESLIDE}/*.el ${LISPDIR}
	@echo ----- Done.

org-bullets :
	@echo ----- Making org-bullets...
	${EMACS} -Q -L ${OBULLETS} -batch -f batch-byte-compile ${OBULLETS}/org-bullets.el
	if [ -e ${LISPDIR}/org/org-bullets.el ]; then rm ${LISPDIR}/org/org-bullets.el; fi
	mv ${OBULLETS}/*.elc ${LISPDIR}/org
	@echo ----- Done.

org-journal :
	@echo ----- Making org-journal...
	${EMACS} -Q -L ${ORGJOURNAL} -batch -f batch-byte-compile ${ORGJOURNAL}/org-journal.el
	if [ -e ${LISPDIR}/org/org-journal.el ]; then rm ${LISPDIR}/org/org-journal.el; fi
	mv ${ORGJOURNAL}/*.elc ${LISPDIR}/org
	@echo ----- Done.

org :
	@echo ----- Making org...
	@echo ----- WARNING! we are over-writing the existing org installation!
	rm -df -R -v ${APPLISPDIR}/org*
	if [ -d ${LISPDIR}/org ]; then rm -df -R ${LISPDIR}/org; fi
	if [ ! -d ${LISPDIR}/org ]; then mkdir ${LISPDIR}/org; fi
	cd ${ORG} && make cleanall
	cd ${ORG} && git checkout ${org_release}
	${MAKE} EMACS=${EMACS} -C ${ORG} all
	${MAKE} EMACS=${EMACS} -no-site-file -no-init-file lispdir=${LISPDIR}/org \
	        datadir=${APPETCDIR}/org infodir=${APPINFODIR} -C ${ORG} install-etc
	${MAKE} EMACS=${EMACS} -no-site-file -no-init-file lispdir=${LISPDIR}/org \
	        datadir=${APPETCDIR}/org infodir=${APPINFODIR} -C ${ORG} install-info
	cp -p -R ${ORG}/lisp/*.el ${LISPDIR}/org/
	cp -p -R ${ORG}/lisp/*.elc ${LISPDIR}/org/
	cp -p -R ${ORG}/contrib/lisp/*.el ${LISPDIR}/org/
	cd ${ORG} && make cleanall
	cd ${ORG} && git checkout master
	@echo ----- Done making org

org-async :
	@echo ----- Making org version 8.0
	if [ -d ${LISPDIR}/org-async ]; then rm -df -R ${LISPDIR}/org-async; fi
	if [ ! -d ${LISPDIR}/org-async ]; then mkdir ${LISPDIR}/org-async; fi
# 	Check out old source code.
	cd ${ORG} && make cleanall
	cd ${ORG} && git checkout ${org_release_async}
	cd ${ORG} && make cleanall
	${MAKE} EMACS=${EMACS} -C ${ORG} all
	${MAKE} EMACS=${EMACS} lispdir=${LISPDIR}/org-async \
	        datadir=${APPETCDIR}/org infodir=${APPINFODIR} -C ${ORG} install-etc
	${MAKE} EMACS=${EMACS} lispdir=${LISPDIR}/org-async \
	        datadir=${APPETCDIR}/org infodir=${APPINFODIR} -C ${ORG} install-info
	cp -p -R ${ORG}/lisp/*.el ${LISPDIR}/org-async/
	cp -p -R ${ORG}/lisp/*.elc ${LISPDIR}/org-async/
	cp -p -R ${ORG}/contrib/lisp/*.el ${LISPDIR}/org-async/
	cd ${ORG} && make cleanall
	cd ${ORG} && git checkout master
	@echo ----- Done making org-async

org-sync :
	@echo ----- Making org-sync
	cp ${OS}/*.el ${LISPDIR}/
	@echo ----- Done.

other :
	@echo ----- compile all .el files...
	if [ ! -d ${LISPDIR} ]; then mkdir ${LISPDIR}; fi
	${ELCC} -f batch-byte-compile src/other/ssh.el
	${ELCC} -f batch-byte-compile src/other/fixpath.el
	${ELCC} -f batch-byte-compile src/other/frame-fns.el
#	${ELCC} -batch -f batch-byte-compile other/frame-cmds.el
	${ELCC} -f batch-byte-compile src/other/framepop.el
	${ELCC} -f batch-byte-compile src/other/import-env-from-shell.el
#	${ELCC} -batch -f batch-byte-compile other/osx-itunes.el
	${ELCC} -f batch-byte-compile src/other/psvn.el
#	${ELCC} -batch -f batch-byte-compile src/other/ox-ravel.el
#	${ELCC} -batch -f batch-byte-compile src/other/markdown-mode.el
	cp -p src/other/*.el ${LISPDIR}/
	mv src/other/*.elc ${LISPDIR}/
	@echo ----- Done.

poly:
	@echo ----- Making polymode...
	cd ${POLY} && git checkout ${polymode_release}
	cd ${POLYR} && git checkout ${polymode_release}
	cd ${POLYMARK} && git checkout ${polymode_release}
	cd ${POLYORG} && git checkout ${polymode_release}
	cd ${POLYNW} && git checkout ${polymode_release}
	if [ ! -d ${PREFIX}/site-lisp/polymode ]; then mkdir ${PREFIX}/site-lisp/polymode; fi
	if [ ! -d ${PREFIX}/site-lisp/poly-R ]; then mkdir ${PREFIX}/site-lisp/poly-R; fi
	if [ ! -d ${PREFIX}/site-lisp/poly-markdown ]; then mkdir ${PREFIX}/site-lisp/poly-markdown; fi
	if [ ! -d ${PREFIX}/site-lisp/poly-org ]; then mkdir ${PREFIX}/site-lisp/poly-org; fi
	if [ ! -d ${PREFIX}/site-lisp/poly-noweb ]; then mkdir ${PREFIX}/site-lisp/poly-noweb; fi
	cp ${POLY}/*.el ${PREFIX}/site-lisp/polymode
	cp ${POLYR}/*.el ${PREFIX}/site-lisp/poly-R
	cp ${POLYMARK}/*.el ${PREFIX}/site-lisp/poly-markdown
	cp ${POLYORG}/*.el ${PREFIX}/site-lisp/poly-org
	cp ${POLYNW}/*.el ${PREFIX}/site-lisp/poly-noweb
	@echo ----- Done.

popup:
	@echo ----- Making popup...
	${ELCC} -f batch-byte-compile ${POPUP}/popup.el
	mv ${POPUP}/*.elc ${LISPDIR}
	@echo ----- Done.

powerline:
	@echo ----- Making powerline...
	cp ${POWERLINE}/*.el ${LISPDIR}
	@echo ----- Done.

s:
	@echo ----- Making s
	${EMACS} -Q -L ${S} -batch -f batch-byte-compile ${S}/*.el
	mv ${S}/*.elc ${LISPDIR}/
	@echo ----- Done.

spaceline:
	@echo ----- Making spaceline
	cp ${SPACELINE}/*.el ${LISPDIR}
	@echo ----- Done.

theme-changer:
	@echo ----- Making theme-changer
	cp ${THEMECHANGER}/*.el ${LISPDIR}
	@echo ----- Done.

transient:
	@echo ----- Making transient
	cp ${TRANSIENT}/lisp/*.el ${LISPDIR}
	@echo ----- Done.

treepy:
	@echo ----- Making treepy...
	cp ${TREEPY}/*.el ${LISPDIR}
	@echo ----- Done.

with-editor:
	@echo ----- Making with-editor...
	cp ${WITHED}/*.el ${LISPDIR}
	@echo ----- Done.

#### Below we have old stuff.


weather-metno :
	@echo ----- Making weather-metno...
	if [ ! -d ${PREFIX}/site-lisp/weather-metno ]; then mkdir ${PREFIX}/site-lisp/weather-metno; fi
	cp -p -R ${WEATHER}/ ${PREFIX}/site-lisp/weather-metno
	@echo ----- Done.

## copy the ox-ravel.el export module. Note: ideally this should first
## update the code with svn, then tangle the ox-ravel.org which generates
## the .el file and then copy the file.
ravel :
	@echo ----- Generating ox-ravel.el
	emacs --batch --visit ${ORGACC}/ox-ravel.org -f org-babel-tangle
	cp -p ${ORGACC}/ox-ravel.el ${PREFIX}/site-lisp/
	@echo ----- Done.



