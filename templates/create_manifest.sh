#! /bin/bash
set -eu

ROOT="$(dirname "${0}")"

source "${ROOT}"/../globals

! check_command cmp sed && exit 3

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
  if diff <(echo "${newmanifest}") "${DIR}/${NAME}.json" > /dev/null; then
    show_success "No changes to ${DIR}/${NAME}.json."
  else
    echo "${newmanifest}" > "${DIR}/${NAME}.json"
    show_success "Updated ${DIR}/${NAME}.json."
  fi
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
  *)
    show_error "ERROR: ${TYPE@Q} not understood. Exiting."
    exit 3
    ;;
esac
shopt -u extglob
