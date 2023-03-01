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
  ryokanroom
  smalljapaneseprovincialtown
  streetclub
  tokyostreet
  twoqueenscities
  yunjingcity)

function download_bg {
  local dir="${1}"
  local key
  if [ -f "${dir}/data" ]; then
    source "${dir}/data"
    for key in "${!BG[@]}"; do
      wget --quiet --show-progress -N -c -O "${dir}/${dir}-${key}.jpg" "${BG[${key}]}"
      # sleep "$((RANDOM % 5 + 5))"
    done
    sleep "$((RANDOM % 5 + 5))"
  else
    echo "No data file in ${dir@Q}. Skipping..."
  fi
}

for DIR in "${DIRS[@]}"; do
  download_bg "${DIR}"
done
