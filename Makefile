PREFIX ?= /usr

PROGRAM ?= Timed
DATA = metadata.json
DIRS = $(shell cat data) firewatch metropolis mountainside
BACKGROUNDS = $(foreach background, $(DIRS), $(join $(background), /$(background).avif))

.PHONY: all

all: $(BACKGROUNDS)

%.avif: %.json
	kdynamicwallpaperbuilder $< --output $@

install: all
	mkdir -p $(PREFIX)/share/wallpapers/$(PROGRAM)/contents/images
	cp $(DATA) $(PREFIX)/share/wallpapers/$(PROGRAM)/
	cp $(BACKGROUNDS) $(PREFIX)/share/wallpapers/$(PROGRAM)/contents/images

uninstall:
	rm -f $(addprefix $(PREFIX)/share/wallpapers/$(PROGRAM)/, $(DATA))
	rm -f $(addprefix $(PREFIX)/share/wallpapers/$(PROGRAM)/contents/images/, $(notdir $(BACKGROUNDS)))
	rmdir --ignore-fail-on-non-empty $(PREFIX)/share/wallpapers/$(PROGRAM)
	rmdir --ignore-fail-on-non-empty $(PREFIX)/share/wallpapers/

.PHONY: clean

clean:
	-rm -f $(BACKGROUNDS)
