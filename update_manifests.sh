#!/bin/bash

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

set -eu

./templates/create_manifest.sh -d 24hours -t morning-day-evening-night_fixed
./templates/create_manifest.sh -d akihabarasouthexit -t day-sunset-night
# ./templates/create_manifest.sh -d catherineroom
# ./templates/create_manifest.sh -d corporationhall
./templates/create_manifest.sh -d corporationstreet -t day-sunset-night
./templates/create_manifest.sh -d elliemansion -t day-sunset-night
./templates/create_manifest.sh -d firewatch -t day-sunset-night
./templates/create_manifest.sh -d himitsuhouse -t day-sunset-night
# ./templates/create_manifest.sh -d himitsuhouseinterior
./templates/create_manifest.sh -d island -t day-night
./templates/create_manifest.sh -d japanesegarden -t day-sunset-night
./templates/create_manifest.sh -d japanesevillagehouse -t morning-day-sunset-night
./templates/create_manifest.sh -d japanesevillagehouseinterior -t morning-day-sunset-night
./templates/create_manifest.sh -d jrstation -t day-sunset-night
# ./templates/create_manifest.sh -d kagomeroom
./templates/create_manifest.sh -d kumoha103train -t day-night
./templates/create_manifest.sh -d kyosukeroom -t day-sunset-night
./templates/create_manifest.sh -d mechanicalcity -t day-night
./templates/create_manifest.sh -d mermaidseamarket -t morning-day-sunset-night
./templates/create_manifest.sh -d metropolis -t day-night
./templates/create_manifest.sh -d michaelroom -t day-sunset-night
./templates/create_manifest.sh -d mountainside -t day-night
./templates/create_manifest.sh -d oldhouse -t day-sunset-night
./templates/create_manifest.sh -d oldhouselivingdiningrooms -t day-sunset-night
# ./templates/create_manifest.sh -d oldhouseroom
# ./templates/create_manifest.sh -d restaurantinterior
# ./templates/create_manifest.sh -d restaurantstreet
./templates/create_manifest.sh -d riverside -t day-sunset-night
./templates/create_manifest.sh -d riversidebridge -t day-night
# ./templates/create_manifest.sh -d ryokanroom
./templates/create_manifest.sh -d smalljapaneseprovincialtown -t morning-day-sunset-night
./templates/create_manifest.sh -d streetclub -t day-night
./templates/create_manifest.sh -d tokyostreet -t day-sunset-night
./templates/create_manifest.sh -d twoqueenscities -t day-night
./templates/create_manifest.sh -d valentinmusiccity -t day-night
./templates/create_manifest.sh -d yunjingcity -t day-night
