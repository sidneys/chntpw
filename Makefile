#
# Makefile for the Offline NT Password Editor
#
#
# Change here to point to the needed OpenSSL libraries & .h files
# See INSTALL for more info.
#

#SSLPATH=/usr/local/ssl
#OSSLPATH=/usr/local/opt/openssl
OSSLPATH=/opt/homebrew/Cellar/openssl@1.1/1.1.1k
OSSLINC=$(OSSLPATH)/include

CC=gcc

# 64 bit if default for compiler setup
CFLAGS= -DUSEOPENSSL -g -I. -I$(OSSLINC) -Wl
OSSLLIB=$(OSSLPATH)/lib


# This is to link with whatever we have, SSL crypto lib we put in static
#LIBS=-L$(OSSLLIB) $(OSSLLIB)/libcrypto.a
LIBS=-L$(OSSLLIB) $(OSSLLIB)/libcrypto.a
all: chntpw cpnt reged

chntpw: chntpw.o ntreg.o edlib.o
	$(CC) $(CFLAGS) -o chntpw chntpw.o ntreg.o edlib.o $(LIBS)

cpnt: cpnt.o
	$(CC) $(CFLAGS) -o cpnt cpnt.o $(LIBS)

reged: reged.o ntreg.o edlib.o
	$(CC) $(CFLAGS) -o reged reged.o ntreg.o edlib.o


#ts: ts.o ntreg.o
#	$(CC) $(CFLAGS) -nostdlib -o ts ts.o ntreg.o $(LIBS)

# -Wl,-t

.c.o:
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f *.o chntpw chntpw.static cpnt reged reged.static *~

