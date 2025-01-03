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

source "${ROOT}"/../globals

! check_command bc cmp find sed && exit 3

#
# Functions
#

function make_manifest {
  local file="${1}"
  local suffix
  local name="${NAME}"
  local newmanifest
  if [[ "${name}" =~ \-4k ]]; then
    # name="$(echo "${name}" | sed -e "s/-4k//g")"
    name="${name//-4k/}"
    suffix=4k
  fi
  newmanifest="$(sed -e "s/\(\"FileName\":\) \"\(.*\)\"/\1 \"${name}-\2${suffix:+-${suffix}}\.${IMG}\"/g" "${file}")"
  if [ -f "${DIR}/${NAME}.json" ] && cmp -s <(echo "${newmanifest}") "${DIR}/${NAME}.json"; then
    show_success "No changes to ${DIR}/${NAME}.json."
  else
    echo "${newmanifest}" > "${DIR}/${NAME}.json"
    show_success "Updated ${DIR}/${NAME}.json."
  fi
}

function make_equal_manifest {
  local name="${NAME}"
  local count
  local idx
  local interval
  count="$(find "${DIR}" -type f -iname "*.${IMG}" -print | wc -l)"
  interval="$(echo "60 * 24 / ${count}" | bc -l)"
  {
    cat << EOF
{
  "Type": "solar",
  "Meta": [
EOF
    for idx in $(seq 1 "${count}"); do
      if [ "${idx}" -eq "${count}" ]; then
        cat << EOF
    {
      "CrossFade": true,
      "Time": "$(min_to_hhmm "${idx}" "${interval}" "${count}")",
      "FileName": "${NAME}-${idx}.${IMG}"
    }
EOF
      else
        cat << EOF
    {
      "CrossFade": true,
      "Time": "$(min_to_hhmm "${idx}" "${interval}" "${count}")",
      "FileName": "${NAME}-${idx}.${IMG}"
    },
EOF
      fi
    done
    cat << EOF
  ]
}
EOF
  } > "${DIR}/${NAME}.json"
}

function min_to_hhmm {
  local idx="${1}"
  local interval="${2}"
  local count="${3}"

  local min
  if [ "${idx}" -eq "${count}" ]; then
    min="$(echo "24 * 60 - ${interval}" | bc -l)"
  else
    min="$(echo "(${idx} - 1) * ${interval}" | bc -l)"
  fi
  printf -v min "%.0f\n" "${min}"
  TZ=UTC date -d "$(TZ=UTC date -d "@0") + ${min} minutes" "+%H:%M"
}

#
# Main
#

OPTIONS=d:n:i:t:
LONGOPTIONS=dir:,name:,image:,type:
PARSED=$(getopt -o ${OPTIONS} --long ${LONGOPTIONS} -n "${0}" -- "${@}")
eval set -- "${PARSED}"

while [ ${#} -ge 1 ]; do
  case "${1}" in
    -d | --dir)
      DIR="${2}"
      shift 2
      ;;
    -n | --name)
      NAME="${2}"
      shift 2
      ;;
    -i | --image)
      IMG="${2}"
      shift 2
      ;;
    -t | --type)
      TYPE="${2}"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      show_error "ERROR"
      exit 3
      ;;
  esac
done

# Defaults and checks
NAME="${NAME:-$(basename "${DIR}")}"
IMG="${IMG:-jpg}"
! [ -d "${DIR}" ] && exit 3
[ -z "${TYPE}" ] && exit 3

shopt -s extglob
case "${TYPE//_/-}" in
  day-night)
    make_manifest "${ROOT}"/day-night.json
    ;;
  day-@(evening|sunset)-night)
    make_manifest "${ROOT}"/day-sunset-night.json
    ;;
  @(morning|sunrise)-day-@(evening|sunset)-night)
    make_manifest "${ROOT}"/morning-day-sunset-night.json
    ;;
  @(morning|sunrise)-day-@(evening|sunset)-night-@(fixed|static))
    make_manifest "${ROOT}"/morning-day-sunset-night_fixed.json
    ;;
  equal)
    make_equal_manifest
    ;;
  *)
    show_error "ERROR: ${TYPE@Q} not understood. Exiting."
    exit 3
    ;;
esac
shopt -u extglob
