PREFIX ?= /usr

PROGRAM ?= Timed
DATA = metadata.json
DIRS = \
	24hours \
	akihabarasouthexit \
	catherineroom \
	corporationstreet \
	corporationhall \
	elliemansion \
	firewatch \
	himitsuhouse \
	himitsuhouseinterior \
	island \
	japanesegarden \
	japanesevillagehouse \
	japanesevillagehouseinterior \
	jrstation \
	kagomeroom \
	kyosukeroom \
	mechanicalcity \
	metropolis \
	michaelroom \
	mountainside \
	oldhouse \
	oldhouselivingdiningrooms \
	oldhouseroom \
	restaurantinterior \
	restaurantstreet \
	riverside \
	ryokanroom \
	smalljapaneseprovincialtown \
	streetclub \
	tokyostreet \
	twoqueenscities \
	yunjingcity

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
	rmdir --ignore-fail-on-empty $(PREFIX)/share/wallpapers/$(PROGRAM)
	rmdir --ignore-fail-on-empty $(PREFIX)/share/wallpapers/

.PHONY: clean

clean:
	-rm -f $(BACKGROUNDS)

