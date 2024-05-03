# SPDX-FileCopyrightText: 2023 - 2024 sudorook <daemon@nullcodon.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>.

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
