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

ROOT="$(dirname "${0}")"

source "${ROOT}"/globals

! check_command curl && exit 3

readarray -t DIRS < "${ROOT}/data"

function download_bg {
  local dir="${1}"
  local file
  local key
  if [ -f "${dir}/data" ]; then
    source "${dir}/data"
    for key in "${!BG[@]}"; do
      file="${dir}/${dir}-${key}.jpg"
      if ! [ -f "${file}" ]; then
        show_info -n "Downloading ${file@Q}..."
        if curl -s -C - -o "${file}" "${BG[${key}]}"; then
          sleep "$((RANDOM % 5 + 5))"
          show_info " done."
        else
          echo
          show_error "ERROR: failed to download ${file@Q}."
          exit 3
        fi
      else
        echo "'${dir}/${dir}-${key}.jpg' already exists."
      fi
    done
    unset BG
  else
    show_warning "No data file in ${dir@Q}. Skipping..."
  fi
}

for DIR in "${DIRS[@]}"; do
  download_bg "${DIR}"
done
