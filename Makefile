# Generated automatically from Makefile.in by configure.
#### Start of system configuration section. ####
 srcdir = .

CFLAGS = -g -O
prefix = /usr/local
man1dir=${prefix}/man/man1
exec_prefix = ${prefix}
bindir=$(exec_prefix)/bin

INSTALL=/usr/bin/install -c

# Extension (not including `.') for the manual page filenames.
manext = 8
# Where to put the manual pages.
mandir = $(prefix)/man/man$(manext)

#### End of system configuration section. ####

SHELL = /bin/sh

SRC = adjtimex.c adjtimex.man install-sh configure.in \
 configure Makefile.in README adjtimex.lsm

MISC = Makefile adjtimex.man README  adjtimex.lsm
DISTFILES = $(MISC) $(SRCS)

all: adjtimex

adjtimex: adjtimex.c
	$(CC) $(CFLAGS) -o adjtimex adjtimex.c
	
install: all
	$(INSTALL) -g bin -m 755 -o root adjtimex $(bindir)/adjtimex
	-$(INSTALL) -g man -m 444 -o root $(srcdir)/adjtimex.man \
		$(mandir)/adjtimex.$(manext)

uninstall:
	rm -f $(bindir)/adjtimex $(mandir)/adjtimex.$(manext)

clean: 
	rm -f core *.o
veryclean: clean
	rm -f adjtimex

shar: $(SRC)
	distname=`sed -e '/Id.*adjtimex.c/!d' \
		-e 's/[^0-9]*\([0-9.]*\).*/adjtimex-\1/' \
		-e q adjtimex.c`; \
	shar $(SRC) >$$distname.shar 

dist: $(SRC)
	distname=`sed -e '/Id.*adjtimex.c/!d' \
		-e 's/[^0-9]*\([0-9.]*\).*/adjtimex-\1/' \
		-e q adjtimex.c`; \
	rm -fr $$distname; \
	mkdir $$distname; \
	for file in $(SRC); do \
	  ln $$file $$distname/$$file \
	  || { echo copying $$file instead; cp -p $$file $$distname/$$file;}; \
	done; \
	chmod -R a+rX $$distname; \
	tar -chz -f $$distname.tar.gz $$distname; \
	rm -fr $$distname
