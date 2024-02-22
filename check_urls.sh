#! /bin/bash
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
