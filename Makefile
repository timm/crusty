BIN     = /bin/sh
DESTDIR = $(HOME)
Tmp     = ~/tmp
 
Snownews = 1.5.7
Xgawk    = 3.1.5-beta.20060401
XgawkLib = list math misc os string trees

VimOutliner = 0.3.4

CRUSTY_SVN=https://crusty.googlecode.com/svn/

Dirs    = opt opt/crusty svns tmp tmp/backup var var/log .crusty \
          bin doc doc/wiki doc/man doc/html    etc etc/login lib share 
AptDirs = bin doc doc/wiki doc/man doc/html eg etc etc/login lib share 

VimColors = .vim/colors
VimDirs   = .vim .vim/plugin $(VimColors)

###########################################################################

all: snownews

install : hello installdirs apps bash editors screen done

editors : nano vim emacs

apps : crusty svns installsnownews  xgawk myawk

showapps :
	tree -L 1 $(DESTDIR)/opt 

hello : doc/hello.txt
	@cat doc/hello.txt

installdirs :
	@if [ ! -d "$(Tmp)" ]; then mkdir -p $(Tmp); fi
	@$(foreach x, $(Dirs),  if [ ! -d "$(DESTDIR)/$x" ]; then mkdir -p $(DESTDIR)/$x; fi; )

dist :
	cd $(Tmp) ;                     \
	svn export $(CRUSTY_SVN) crusty; \
	zip -r crusty.zip crusty;         \
	ls -lsa crusty.zip;                \
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

snownews : 
	@make  name=snownews application $(DESTDIR)/opt/crusty/snownews/bin/snownews -s 

$(DESTDIR)/opt/crusty/snownews/bin/snownews : rss-snownews/snownews-$(Snownews).tar.gz 
	if [ ! -d $(Tmp)/snownews ]; then mkdir $(Tmp)/snownews; fi; 
	cp rss-snownews/snownews-$(Snownews).tar.gz $(Tmp)/snownews;
	cd $(Tmp)/snownews;  tar xfz snownews-$(Snownews).tar.gz ; 
	cd $(Tmp)/snownews/snownews-$(Snownews) ; \
		./configure --prefix=$(DESTDIR)/opt/crusty/snownews ;  \
		make

installsnownews : snownews
	make name=snownews application 
	cd $(Tmp)/snownews/snownews-$(Snownews) ; \
		make install

# ---------------------------------------------
# application #4: xgawk
#    a better gawk (with xml support)

xgawk :  
	make name=xgawk application -s
	make $(DESTDIR)/opt/crusty/xgawk/bin/xgawk

$(DESTDIR)/opt/crusty/xgawk/bin/xgawk : xml-gawk/xgawk-$(Xgawk).tar.gz
	if [ ! -d $(Tmp)/xgawk ]; then mkdir $(Tmp)/xgawk; fi; 
	cp xml-gawk/xgawk-$(Xgawk).tar.gz $(Tmp)/xgawk;
	cd $(Tmp)/xgawk;  tar xfz xgawk-$(Xgawk).tar.gz 
	cd $(Tmp)/xgawk/xgawk-$(Xgawk); \
		./configure --prefix=$(DESTDIR)/opt/crusty/xgawk ;  \
		make ;\
		make install
 
# ---------------------------------------------
# bash

bash : bashrc bash_profile bashdocs

bashrc : $(DESTDIR)/opt/crusty/crusty/etc/dotbashrc 
	@if [ ! -f "$(HOME)/.bashrc" ]; \
	then echo '. $(DESTDIR)/opt/crusty/crusty/etc/dotbashrc' > $(HOME)/.bashrc; \
	fi

$(DESTDIR)/opt/crusty/crusty/etc/dotbashrc : etc/dotbashrc       
	@cp -v $< $@	

bash_profile : $(DESTDIR)/opt/crusty/crusty/etc/dotbash_profile 
	@if [ ! -f "$(HOME)/.bash_profile" ]; \
	then echo '. $(DESTDIR)/opt/crusty/crusty/etc/dotbash_profile' > $(HOME)/.bash_profile; \
	fi

$(DESTDIR)/opt/crusty/crusty/etc/dotbash_profile : etc/dotbash_profile 
	@cp -v $< $@	

bashdocs : doc/sandbox.emf
	@make app=crusty x=sandbox  doco 

# 
# ---------------------------------------------
# documents

doco : 	$(DESTDIR)/opt/crusty/$(app)/doc/man/$x.man \
		$(DESTDIR)/opt/crusty/$(app)/doc/html/$x.html

$(DESTDIR)/opt/crusty/$(app)/doc/man/$x.man   : doc/$x.emf 
	groff -Tascii -man $< > $@
$(DESTDIR)/opt/crusty/$(app)/doc/html/$x.html : doc/$x.emf  
	groff -Thtml -man $< > $@

# 
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
# myawk

needz : myawk
myawk : xgawk needz-install needz-support needz-apps
needz-install : 
	make name=needz application needz-support
	@$(foreach t, $(XgawkLib), \
		if   [ ! -d $(DESTDIR)/opt/crusty/needz/lib/$t ]; \
        then mkdir  $(DESTDIR)/opt/crusty/needz/lib/$t  ; \
        fi ; \
		make d=$(DESTDIR)/opt/crusty/needz/lib t=$t needz-lib; )

needz-lib :
	@cd needz/lib/$t ; \
		$(foreach f, $(notdir $(wildcard needz/lib/$t/*.awk)),  \
				if [ $f -nt $d/$t/$f ]; then cp -v $f $d/$t/$f;  fi; )

needz-support: \
	$(DESTDIR)/opt/crusty/needz/lib/includes.m4      \
	$(DESTDIR)/opt/crusty/needz/etc/login/dotneedz \
	$(DESTDIR)/opt/crusty/needz/bin/needz 
	@echo "export Needz=$(DESTDIR)/opt/crusty/needz" > $(DESTDIR)/opt/crusty/needz/etc/login/0

$(DESTDIR)/opt/crusty/needz/lib/includes.m4     : needz/includes.m4 ;  @cp -v $< $@	
$(DESTDIR)/opt/crusty/needz/etc/login/dotneedz  : needz/dotneedz ;  @cp -v $< $@	
$(DESTDIR)/opt/crusty/needz/bin/needz           : needz/needz    
	echo "#!`which bash`" > $@ 
	cat  $< >> $@
	chmod +x $@

needz-apps: needz-bars needz-malign

needz-bars :
	@cd needz-apps/bars && needz bars
	@cd needz-apps/bars/eg && chmod +x 0 1 2 3 4 5

needz-malign :
	@cd needz-apps/malign && needz malign
	@cd needz-apps/malign/eg && chmod +x 0 1 2 

# ---------------------------------------------
# done
done : showapps doc/done.txt
	sh doc/done.txt $(DESTDIR)
