#! /bin/bash
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
