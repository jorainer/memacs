<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. memacs</a>
<ul>
<li><a href="#sec-1-1">1.1. Installation</a>
<ul>
<li><a href="#sec-1-1-1">1.1.1. Requirements</a></li>
<li><a href="#sec-1-1-2">1.1.2. Suggestions</a></li>
<li><a href="#sec-1-1-3">1.1.3. Trouble shooting</a></li>
</ul>
</li>
<li><a href="#sec-1-2">1.2. Usage</a>
<ul>
<li><a href="#sec-1-2-1">1.2.1. Configuration</a></li>
</ul>
</li>
<li><a href="#sec-1-3">1.3. Development</a>
<ul>
<li><a href="#sec-1-3-1">1.3.1. Versions and change log</a></li>
<li><a href="#sec-1-3-2">1.3.2. TODOs</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>

---

# memacs<a id="sec-1"></a>

memacs (short for my personal emacs; maybe in analogy to Depeche Mode's my personal Jesus?) is a collection of `make` files and configuration templates to create an Emacs environment I found very useful to work with (in day-to-day use as well as for analyses based on `R` but also other programming/script languages).

## Installation<a id="Installation"></a><a id="sec-1-1"></a>

Relatively straight forward, clone from git. However, since we're using a self certified ssl certificate it all gets a little bit more complicated. On MacOS it is sufficient to enter `https://manny.i-med.ac.at` in Safari (not any other browser!), add an exception and **permanently save the certificate**.
On unix, call `echo | openssl s_client -connect manny.i-med.ac.at:443 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > manny-cert.pem` save that certificate (`manny-cert.pem`) to some path (.e.g. *~.*.certs/). Now we have to configure `git` to accept (actually find) this certificate: add the line `export GIT_SSL_CAPATH=/home/jo/.certs/` (replacing *jo* with your user name) into your bash profile file.
After that (make shure the `GIT_SSL_CAPATH` environment variable is set) we can clone the package: `git clone https://manny.i-med.ac.at/jo/memacs.git`.

All required emacs extensions will also be fetched using `make fetch` (see Section 1.2 above).

In order to overwrite the `org-mode` package that is shipped with Emacs (and which is pretty outdated), you might need superuser rights (or make the `lisp/org` folder of the Emacs installation writable).

### Requirements<a id="sec-1-1-1"></a>

-   Emacs: Obviously (a recent) Emacs has to be installed.
    -   Mac OS X:
        -   Download and install Emacs from <http://emacsformacosx.com/> (Aquamacs or other Emacs suites with lots of pre-installed packages are not suggested).
        -   Alternatively download and compile Emacs from source (e.g. using <https://github.com/jimeh/build-emacs-for-osx.git>).

    -   Unix:
        -   Download Emacs source code from <ftp://ftp.gnu.org/gnu/emacs/> (e.g. using `wget ftp://ftp.gnu.org/gnu/emacs/emacs-24.3.tar.gz`), `configure`, `make` and `make install` (on CentOS/RedHat you may want to set `./configure --without-gsettings` due to some *property* with RedHat related packages).

-   A recent TexLive installation is suggested (definitely not the one that is shipped with CentOS).
    -   MacOS: download the *dmg* from <http://tug.org/mactex/>.
    -   Unix/others: download `install-tl-unx.tar.gz` from <http://www.tug.org/texlive/> (e.g. `wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz`), unzip/tar (`tar -xzf install-tl-unx.tar.gz`) and run `install-tl-*` (`cd install-tl-*` and `./install-tl`; note: you might have to be root to install TexLive). After installation, do not forget to add the path to the newly installed TexLive to your `PATH` environment variable.

-   The python based generic syntax highlighting tool `pygments` is suggested too (e.g. using `pip install pygments`) to enable syntax highlighting in exported `org-mode` files.

### Suggestions<a id="sec-1-1-2"></a>

A decent monospace font might be nice to have. Examples:

-   *inconsolata*: very nice open source font, get it from google fonts: <https://www.google.com/fonts>; click on *Add to Collection*, and click on the *arrow down* on the top right side of the page which allows you to download the selected fonts.

-   *Source Code Pro*: get it also from the google web fonts.

-   *Ubuntu Mono*: also from google web fonts.

### Trouble shooting<a id="sec-1-1-3"></a>

1.  Problems installing `auto-complete` or any of its dependencies.

    On some systems/network configurations it might not be possible to clone packages from github using `git://github.com` urls and thus `auto-complete` fails to fetch required packages. To fix this, got to the `tmp/auto-complete` folder and change all `git://` to `https://` in the `.gitmodules` file and `.git/config`. Also, you have to replace all `git://` by `https://` in `lib/popup/.gitmodules`. If the problem still persists some more of these urls might have to be replaced (if present also in `.git/modules/lib` and sub folders).

## Usage<a id="Usage"></a><a id="sec-1-2"></a>

-   **Installation of themes**: themes will be installed to `<PREFIX>/themes`, by default to `~/.emacs.d/themes`. The `PREFIX` variable can be changed in the `Makeconf` file.
    -   `make all` to fetch/update all themes.
    -   `make goodones` to fetch/update the themes *anti-zenburn*, *noctilux-theme*, *solarized-emacs* and *zenburn-emacs*.

-   **Installation of Emacs extensions**: just call `make` with one of the switches below. The *best* way to do it would be `make fetch`, `make core` and `make addons` in that order.
    -   `all`: downloads, updates and installs all packages.
    -   `createdirs`: creates required directories. Only called internally.
    -   `emacs`: installs all packages, without fetching anything from the internet.
    -   `fetch`: downloads all packages and updates them (does not install them!).
    -   `core`: installs the packages `auctex`, `ess` and `org-mode`. Note that installation of `org-mode` can lead to problems, since this script tries to over-write the org-mode shipped with Emacs.
    -   `addons`: installs `auto-complete`, `other` (iTunes control, `ssh.el`, etc.), `dash`, `git-modes`, `magit` and `org-bullets`.
    -   `auctex`: installs `auctex`.
    -   `ess`: installs `ess` (Emacs speaks statistics).
    -   `org`: installs Emacs `org-mode`.
    -   `auto-complete`: installs `auto-complete`.
    -   `other`: installs some additional `.el` files located in the folder `src/other`.
    -   `dash`: installs `dash.el`, required for the `solarized` theme.
    -   `git-modes`: installs `git-modes`, required for `magit`.
    -   `magit`: installs `magit`, the *magic* git mode.
    -   `org-bullets`: installs `org-bullets`, that allow to replace the `*` from `org-mode` with special bullets.

### Configuration<a id="sec-1-2-1"></a>

Some basic configurations can be done in the `Makeconf` file, e.g. the `PREFIX` where all packages can be installed can be specified, or the `APPPREFIX`, which is on Mac by default `/Applications/Emacs.app/Contents/Resources`. This latter is required to remove/overwrite the `org-mode` that comes with Emacs.

The `.emacs` files are also thought as sort of template for the `~/.emacs` main config file. The template may be changed to local settings (e.g. different font, adapting the path to the installed libraries, etc.).
Most settings assume that the additional packages have been installed to `~/.emacs.d/site-lisp`, thus, if the default was not changed in the `Makeconf` file, not much has to been changed.

Some important things, however, that might still be adapted are:
-   In the `org-mode` section:
    -   the `org-agenda-files` which point to the `org` files that should be screened for TODO items,
    -   eventually custom TODO keywords `org-todo-keywords`,
    -   the default `org-skeleton` defining default settings, LaTeX packages etc to be imported to `org` files (the shortcut `C-S-f4` will insert the skeleton to `org` files),
    -   custom agenda commands and custom tags (see `org-tag-alist` and `org-agenda-custom-commands`).

Additional settings:
-   Font.
-   MobileOrg settings that would allow to synchronize agenda and `org` file with iOS or Android devices running the MobileOrg app.
-   `org-export-async-init-file` allows to specify an emacs init file other than the default one. This is specifically useful when async export yields an error message complaining that the font can not be found.

## Development<a id="sec-1-3"></a>

Please add your name here if you're contributing in whatever way.

-   Johannes Rainer

### Versions and change log<a id="sec-1-3-1"></a>

-   v0.1.3:
    -   Added <https://github.com/purcell/exec-path-from-shell.git> that allows to copy environment variables. Thus, by copying `LC_ALL` some parallel computations do no longer cause a segfault in R started from within Emacs.
    -   Added `arduino-mode`.

-   v0.1.2:
    -   Fixed some org-mode and font related stuff in *.emacs*: `set-face-attribute 'variable-pitch` and `set-face-attribute 'fixed-pitch` also allows to set the font for headers when using the *solarized* color theme.

-   v0.1.1:
    -   Fixed some bugs.

-   v0.1.0:
    -   Should be stable by now. Some bugs fixed and tested on MacOS X and CentOS.

-   v0.0.2:
    -   Fixed some path-related problems.
    -   Added a shell script to run emacs in batch mode to export an `org` file to `latex`, `pdf` or `html`.
    -   Updated the README.org

-   v0.0.1: initial version.

### TODOs<a id="sec-1-3-2"></a>

1.  DONE Write the main `Makefile` to install the packages.

    -   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2014-05-16 Fri 17:21]</span></span>

2.  DONE What with weather-metno?

    -   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2014-05-16 Fri 17:22]</span></span>

    Basically, drop it. Might be installed/setup later.

3.  TODO Find a clever way to install/update the orgmode-accessories.

    To generate the `ox-ravel.el` file we have to first tangle the `ox-ravel.org`. For that we need, obviously, a running emacs with `org-mode` already installed&#x2026; pity.