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
  kumoha103train
  kyosukeroom
  mechanicalcity
  michaelroom
  oldhouse
  oldhouselivingdiningrooms
  oldhouseroom
  restaurantinterior
  restaurantstreet
  riverside
  riversidebridge
  ryokanroom
  smalljapaneseprovincialtown
  streetclub
  tokyostreet
  twoqueenscities
  yunjingcity)

# Check if list of command-line programs are in the PATH.
check_command() {
  local package
  local missing=()
  for package in "${@}"; do
    if ! command -v "${package}" >/dev/null; then
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

function download_bg {
  local dir="${1}"
  local key
  if [ -f "${dir}/data" ]; then
    source "${dir}/data"
    for key in "${!BG[@]}"; do
      if wget --quiet --show-progress -nc -c -O "${dir}/${dir}-${key}.jpg" "${BG[${key}]}"; then
        sleep "$((RANDOM % 5 + 5))"
      else
        echo "'${dir}/${dir}-${key}.jpg' already exists."
      fi
    done
  else
    echo "No data file in ${dir@Q}. Skipping..."
  fi
}

! check_command wget && exit 3

for DIR in "${DIRS[@]}"; do
  download_bg "${DIR}"
done
