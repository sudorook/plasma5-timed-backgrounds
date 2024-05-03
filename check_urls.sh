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

function check_urls {
  local dir="${1}"
  local key
  if [ -f "${dir}/data" ]; then
    source "${dir}/data"
    show_header "Checking ${dir@Q}"
    for key in "${!BG[@]}"; do
      if curl -ILs --retry 5 --retry-connrefused "${BG[${key}]}" > /dev/null; then
        show_success "${key}: ${BG[${key}]}"
        sleep "$((RANDOM % 5 + 5))"
      else
        show_error "${key}: ${BG[${key}]}"
      fi
    done
    echo
    unset BG
  else
    show_warning "No data file in ${dir@Q}. Skipping..."
  fi
}

for DIR in "${DIRS[@]}"; do
  check_urls "${DIR}"
done
