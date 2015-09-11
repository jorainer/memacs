# Makefile to download themes for emacs

# Copyright (C) 2014 Johannes Rainer

# Author: Johannes Rainer

## Set most variables in Makeconf
include ../Makeconf

#PREFIX=~/.emacs.d
#EMACS=emacs
#ELCC=$(EMACS) -batch -q -no-site-file -no-init-file
#RSYNC=rsync -n -avu --exclude="*~"

# where to put the themes.
DESTDIR=${PREFIX}/themes
AZ=tmp/anti-zenburn-theme
LEUVEN=tmp/emacs-leuven-theme
NOCTILUX=tmp/noctilux-theme
SOFTMORNING=tmp/soft-morning-theme
SOLARIZED=tmp/solarized-emacs
ZENBURN=tmp/zenburn-emacs
PROF=tmp/emacs-professional-theme
MOE=tmp/moe-theme.el

all : anti-zenburn emacs-leuven-theme noctilux-theme soft-morning-theme solarized-emacs zenburn-emacs emacs-professional moe-theme

goodones : anti-zenburn noctilux-theme solarized-emacs zenburn-emacs

.PHONY : anti-zenburn clean emacs-leuven-theme noctilux-theme soft-morning-theme solarized-emacs zenburn-emacs

anti-zenburn :
	@echo ----- installing anti-zenburn-theme...
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${AZ} ]; then cd tmp && git clone https://github.com/m00natic/anti-zenburn-theme.git; fi
	cd ${AZ} && git pull
#	${EMACS} -Q -L ${AZ} -batch -f batch-byte-compile ${AZ}/*.el
#	mv ${AZ}/*.elc ${DESTDIR}
	cp -p ${AZ}/*.el ${DESTDIR}
	@echo ----- Done.

emacs-leuven-theme :
	@echo ----- installing emacs-leuven-theme...
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${LEUVEN} ]; then cd tmp && git clone https://github.com/fniessen/emacs-leuven-theme; fi
	cd ${LEUVEN} && git pull
#	${EMACS} -Q -L ${LEUVEN} -batch -f batch-byte-compile ${LEUVEN}/*.el
#	mv ${LEUVEN}/*.elc ${DESTDIR}
	cp -p ${LEUVEN}/*.el ${DESTDIR}
	@echo ----- Done.

emacs-professional :
	@echo ----- installing emacs-professional...
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${PROF} ]; then cd tmp && git clone https://github.com/juanjux/emacs-professional-theme.git; fi
	cd ${PROF} && git pull
	cp -p ${PROF}/*.el ${DESTDIR}
	@echo ----- Done.

moe-theme :
	@echo ----- installing moe-theme...
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${MOE} ]; then cd tmp && git clone https://github.com/kuanyui/moe-theme.el.git; fi
	cd ${NOCTILUX} && git pull
	cp -p ${MOE}/*.el ${DESTDIR}
	@echo ----- Done.


noctilux-theme :
	@echo ----- installing noctilux-theme...
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${NOCTILUX} ]; then cd tmp && git clone https://github.com/stafu/noctilux-theme.git; fi
	cd ${NOCTILUX} && git pull
#	${EMACS} -Q -L ${NOCTILUX} -batch -f batch-byte-compile ${NOCTILUX}/*.el
#	mv ${NOCTILUX}/*.elc ${DESTDIR}
	cp -p ${NOCTILUX}/*.el ${DESTDIR}
	@echo ----- Done.



soft-morning-theme :
	@echo ----- installing soft-morning-theme...
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${SOFTMORNING} ]; then cd tmp && git clone https://github.com/mswift42/soft-morning-theme.git; fi
	cd ${SOFTMORNING} && git pull
#	${EMACS} -Q -L ${SOFTMORNING} -batch -f batch-byte-compile ${SOFTMORNING}/*.el
#	mv ${SOFTMORNING}/*.elc ${DESTDIR}
	cp -p ${SOFTMORNING}/*.el ${DESTDIR}
	@echo ----- Done.

solarized-emacs :
	@echo ----- installing solarized-emacs...
#	dash it, I need dash!
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${SOLARIZED} ]; then cd tmp && git clone https://github.com/bbatsov/solarized-emacs.git; fi
	cd ${SOLARIZED} && git pull
	cp -p ${SOLARIZED}/*.el ${DESTDIR}
#	${EMACS} -Q -L ${SOLARIZED} -batch -f batch-byte-compile ${SOLARIZED}/*.el
#	mv ${SOLARIZED}/*.elc ${DESTDIR}
	@echo ----- Done.

zenburn-emacs :
	@echo ----- installing zenburn-emacs...
	if [ ! -d ${DESTDIR} ]; then mkdir ${DESTDIR}; fi
	if [ ! -d tmp ]; then mkdir tmp; fi
	if [ ! -d ${ZENBURN} ]; then cd tmp && git clone https://github.com/bbatsov/zenburn-emacs.git; fi
	cd ${ZENBURN} && git pull
	cp -p ${ZENBURN}/*.el ${DESTDIR}
#	${EMACS} -Q -L ${ZENBURN} -batch -f batch-byte-compile ${ZENBURN}/*.el
#	mv ${ZENBURN}/*.elc ${DESTDIR}
	@echo ----- Done.



clean :
	@echo ----- Removing all installed themes...
#	Note, we're removing all *.elc files from DESTDIR!
	rm -Rf ${DESTDIR}/*
	rm -Rf tmp/*
	@echo ----- Done.

