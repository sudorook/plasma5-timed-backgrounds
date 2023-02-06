#! /bin/bash
set -eu

DIRS=(24hours
  akihabarasouthexit
  catherineroom
  corporationhall
  corporationstreet
  elliemansion
  himitsuhouse
  himitsuhouseinterior
  island
  japanesegarden
  japanesevillagehouse
  japanesevillagehouseinterior
  jrstation
  kagomeroom
  kyosukeroom
  mechanicalcity
  michaelroom
  oldhouse
  oldhouselivingdiningrooms
  restaurantinterior
  restaurantstreet
  riverside
  ryokanroom
  smalljapaneseprovincialtown
  streetclub
  tokyostreet
  twoqueenscities
  yunjingcity)

function show_success {
  echo -e $'\033[1;35m✓ \033[0m'"$*"
}

function show_header {
  echo -e $'\033[1;36m'"$*"$'\033[0m'
}

function show_error {
  echo -e $'\033[1;31m✗ '"$*"$'\033[0m' 1>&2
}

function show_warning {
  echo -e $'\033[1;33m'"$*"$'\033[0m'
}

function check_urls {
  local dir="${1}"
  local key
  if [ -f "${dir}/data" ]; then
    source "${dir}/data"
    show_header "Checking ${dir}..."
    for key in "${!BG[@]}"; do
      if wget --quiet --method=HEAD "${BG[${key}]}"; then
        show_success "${key}: ${BG[${key}]}"
      else
        show_error "${key}: ${BG[${key}]}"
      fi
    done
    sleep "$((RANDOM % 5 + 5))"
  else
    show_warning "No data file in ${dir@Q}. Skipping..."
  fi
  echo
}

for DIR in "${DIRS[@]}"; do
  check_urls "${DIR}"
done
