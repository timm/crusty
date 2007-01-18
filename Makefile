BIN     = /bin/sh
DESTDIR = $(HOME)

Snownews = 1.5.7
VimOutliner = 0.3.4

CRUSTY_SVN=https://crusty.googlecode.com/svn/

Dirs    = bin doc doc/wiki    etc etc/login lib opt opt/crusty svns tmp tmp/backup var var/log 
AptDirs = bin doc doc/wiki eg etc etc/login lib
VimColors = .vim/colors
VimDirs = .vim .vim/plugin $(VimColors)

###########################################################################

all : hello installdirs apps bash editors screen done

editors : nano vim emacs

apps : crusty svns snownews 

showapps :
	tree -L 1 $(DESTDIR)/opt 

hello : doc/hello.txt
	@cat doc/hello.txt

installdirs :
	@$(foreach x, $(Dirs), if [ ! -d $(DESTDIR)/$x ]; then mkdir -p $(DESTDIR)/$x; fi; )

dist :
	cd /tmp; \
	if [ -d crustyzip ]; then rm -rf crustyzip; fi; \
	mkdir crustyzip; \
	cd crustyzip; 
	svn export $(CRUSTY_SVN) crusty; \
	zip -r crusty.zip crusty; \
	ls -lsa crusty.zip; \
	pwd

# ---------------------------------------------
# generic application
application : installdirs
	@if   [ ! -d  $(DESTDIR)/opt/crusty/$(name) ]; \
	then mkdir   $(DESTDIR)/opt/crusty/$(name) ; \
	fi

	@$(foreach x, $(AptDirs), \
		if   [ ! -d  $(DESTDIR)/opt/crusty/$(name)/$x ]; \
		then mkdir   $(DESTDIR)/opt/crusty/$(name)/$x  ; \
		fi; )

# ---------------------------------------------
# application #1: crusty 
#    at runtime, crusty offers some run time
#    support in an application called, guess what?, "crusty"

crusty : crustyBase crustyStartups

crustyBase :
	@make name=crusty application
	@$(foreach f, $(wildcard bash/* ),   \
		if   [ $f -nt $(DESTDIR)/opt/crusty/crusty/bin/$(notdir $f) ]; \
		then    cp -v $f $(DESTDIR)/opt/crusty/crusty/bin/$(notdir $f) ;      \
		fi; )
	@chmod +x $(DESTDIR)/opt/crusty/crusty/bin/*

crustyStartups: $(DESTDIR)/opt/crusty/crusty/etc/login/hello 

$(DESTDIR)/opt/crusty/crusty/etc/login/hello : etc/login/hello       
	@cp -v $< $@	

# ---------------------------------------------------------------------------
# application #2: svns
#    some svn suppport for svn repositories stores in $HOME/svns

svns :
	@make name=svns application
	@$(foreach f, $(wildcard svn/* ),   \
		if   [ $f -nt $(DESTDIR)/opt/crusty/svns/bin/$(notdir $f) ]; \
		then    cp -v $f $(DESTDIR)/opt/crusty/svns/bin/$(notdir $f) ;      \
		fi; )
	@chmod +x $(DESTDIR)/opt/crusty/svns/bin/*

# ---------------------------------------------
# application #3: snownews
#    a net text-base rss reader

snownews : rss-snownews/snownews-$(Snownews).tar.gz 
	make name=snownews application 
	if [ ! -d $(DESTDIR)/tmp/snownews ]; then mkdir $(DESTDIR)/tmp/snownews; fi; 
	cp rss-snownews/snownews-$(Snownews).tar.gz $(DESTDIR)/tmp/snownews;
	cd $(DESTDIR)/tmp/snownews;  tar xfz snownews-$(Snownews).tar.gz ; 
	cd $(DESTDIR)/tmp/snownews/snownews-$(Snownews) ; \
		./configure --prefix=$(DESTDIR)/opt/crusty/snownews ;  \
		make ;                                           \
		make install

# ---------------------------------------------
# bash

bash : bashrc bash_profile

bashrc : $(DESTDIR)/opt/crusty/crusty/etc/dotbashrc 
	@if [ ! -f "$(HOME)/.bashrc" ]; \
	then echo '. ~/opt/crusty/crusty/etc/dotbashrc' > $(HOME)/.bashrc; \
	fi

$(DESTDIR)/opt/crusty/crusty/etc/dotbashrc : etc/dotbashrc       
	@cp -v $< $@	

bash_profile : $(DESTDIR)/opt/crusty/crusty/etc/dotbash_profile 
	@if [ ! -f "$(HOME)/.bash_profile" ]; \
	then echo '. ~/opt/crusty/crusty/etc/dotbash_profile' > $(HOME)/.bash_profile; \
	fi

$(DESTDIR)/opt/crusty/crusty/etc/dotbash_profile : etc/dotbash_profile 
	@cp -v $< $@	

# ---------------------------------------------
# emacs

emacs : $(DESTDIR)/opt/crusty/crusty/etc/dotemacs
	@if [ ! -f "$(HOME)/.emacs" ]; \
	then echo '(load "$(DESTDIR)/opt/crusty/crusty/etc/dotemacs")' > $(HOME)/.emacs ; \
	else echo 'Ensure  that ~/.emacs includes: '  ;\
	     echo '(load "$(DESTDIR)/opt/crusty/crusty/etc/dotemacs")'  ; \
	fi

$(DESTDIR)/opt/crusty/crusty/etc/dotemacs  : etc/dotemacs
	@cp -v $< $@	

# ---------------------------------------------
# nano

nano :  etc/dotnanorc
	@if [ ! -f "$(HOME)/.nanorc" ]; \
	then cp -v etc/dotnanorc $(HOME)/.nanorc; \
	else echo 'Ensure  that ~/.nanorc exists.'  ;\
	fi
# ---------------------------------------------
# vim

vim : vimDirs vimColors vimRc  vimOutliner

vimRc : $(DESTDIR)/opt/crusty/crusty/etc/dotvimrc 
	@if [ ! -f "$(HOME)/.vimrc" ]; \
	then echo 'source $(DESTDIR)/opt/crusty/crusty/etc/dotvimrc' > $(HOME)/.vimrc ; \
	else echo 'Ensure  that ~/.vimrc includes: '  ;\
	     echo 'source $(DESTDIR)/opt/crusty/crusty/etc/dotvimrc'  ; \
	fi

$(DESTDIR)/opt/crusty/crusty/etc/dotvimrc  : etc/dotvimrc
	@cp -v $< $@	

vimDirs :
	@$(foreach x, $(VimDirs), if [ ! -d $(DESTDIR)/$x ]; then mkdir $(DESTDIR)/$x; fi; )

vimColors : $(DESTDIR)/$(VimColors)
	@$(foreach f, $(wildcard vim/colors/* ), \
	if   [ $f -nt $(DESTDIR)/$(VimColors)/$(notdir $f) ];    \
	then cp -v $f    $(DESTDIR)/$(VimColors);         \
	fi; )

vimOutliner : vim/vimoutliner-${VimOutliner}
	cd vim/vimoutliner-${VimOutliner}; ./install.sh

# ---------------------------------------------
# screen
# start here
#
screen : $(DESTDIR)/opt/crusty/crusty/etc/dotscreenrc
	@if [ ! -f "$(HOME)/.screenrc" ]; \
	then echo 'source "$(DESTDIR)/opt/crusty/crusty/etc/dotscreenrc"' > $(HOME)/.screenrc ; \
	else echo 'The file ~/.screenrc could use this line: '; \
	     echo 'source "$(DESTDIR)/opt/crusty/crusty/etc/dotscreenrc"' ; \
	fi

$(DESTDIR)/opt/crusty/crusty/etc/dotscreenrc  : etc/dotscreenrc
	@cp -v $< $@	
# ---------------------------------------------
# done
done : showapps doc/done.txt
	cat doc/done.txt
