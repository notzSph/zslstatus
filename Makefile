# zSlstatus - zSph status monitor
# See LICENSE file for copyright and license details
.POSIX:

include config.mk

REQ = util
COM =\
	components/alsa_master_vol\
	components/battery\
	components/cat\
	components/cpu\
	components/datetime\
	components/disk\
	components/entropy\
	components/hostname\
	components/ip\
	components/kernel_release\
	components/keyboard_indicators\
	components/keymap\
	components/load_avg\
	components/netspeeds\
	components/num_files\
	components/ram\
	components/run_command\
	components/swap\
	components/temperature\
	components/uptime\
	components/user\
	components/volume\
	components/wifi

all: zslstatus

$(COM:=.o): config.mk $(REQ:=.h) zslstatus.h
zslstatus.o: zslstatus.c zslstatus.h arg.h config.h config.mk $(REQ:=.h)

.c.o:
	$(CC) -o $@ -c $(CPPFLAGS) $(CFLAGS) $<

config.h:
	cp config.def.h $@

zslstatus: zslstatus.o $(COM:=.o) $(REQ:=.o)
	$(CC) -o $@ $(LDFLAGS) $(COM:=.o) $(REQ:=.o) zslstatus.o $(LDLIBS)

clean:
	rm -f zslstatus zslstatus.o $(COM:=.o) $(REQ:=.o) zslstatus-$(VERSION).tar.gz

dist:
	rm -rf "zslstatus-$(VERSION)"
	mkdir -p "zslstatus-$(VERSION)/components"
	cp -R LICENSE Makefile README.md config.mk config.def.h \
	      arg.h zslstatus.h zslstatus.c $(REQ:=.c) $(REQ:=.h) \
	      zslstatus.1 "zslstatus-$(VERSION)"
	cp -R $(COM:=.c) "zslstatus-$(VERSION)/components"
	tar -cf - "zslstatus-$(VERSION)" | gzip -c > "zslstatus-$(VERSION).tar.gz"
	rm -rf "zslstatus-$(VERSION)"

install: all
	mkdir -p "$(DESTDIR)$(PREFIX)/bin"
	cp -f zslstatus "$(DESTDIR)$(PREFIX)/bin"
	chmod 755 "$(DESTDIR)$(PREFIX)/bin/zslstatus"
	mkdir -p "$(DESTDIR)$(MANPREFIX)/man1"
	cp -f zslstatus.1 "$(DESTDIR)$(MANPREFIX)/man1"
	chmod 644 "$(DESTDIR)$(MANPREFIX)/man1/zslstatus.1"

uninstall:
	rm -f "$(DESTDIR)$(PREFIX)/bin/zslstatus"
	rm -f "$(DESTDIR)$(MANPREFIX)/man1/zslstatus.1"
