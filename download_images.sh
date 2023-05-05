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

for DIR in "${DIRS[@]}"; do
  download_bg "${DIR}"
done
