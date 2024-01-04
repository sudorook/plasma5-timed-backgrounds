#! /bin/bash
set -eu

ROOT="$(dirname "${0}")"
source "${ROOT}"/globals

readarray -t DIRS < "${ROOT}/data"

# Check if list of command-line programs are in the PATH.
check_command() {
  local package
  local missing=()
  for package in "${@}"; do
    if ! command -v "${package}" > /dev/null; then
      missing+=("${package}")
    fi
  done
  if [ ${#missing[@]} -eq 0 ]; then
    return 0
  else
    show_error "MISSING: ${missing[*]@Q} not installed."
    return 1
  fi
}
export -f check_command

function check_urls {
  local dir="${1}"
  local key
  if [ -f "${dir}/data" ]; then
    source "${dir}/data"
    show_header "Checking ${dir}..."
    for key in "${!BG[@]}"; do
      if wget --quiet --method=HEAD "${BG[${key}]}"; then
        show_success "${key}: ${BG[${key}]}"
        sleep "$((RANDOM % 5 + 5))"
      else
        show_error "${key}: ${BG[${key}]}"
      fi
    done
    unset BG
  else
    show_warning "No data file in ${dir@Q}. Skipping..."
  fi
  echo
}

! check_command wget && exit 3

for DIR in "${DIRS[@]}"; do
  check_urls "${DIR}"
done
