#! /bin/sh

_info_pull() {
  cat << EOF
Pull all remote changes for projects and apply them locally.
EOF
}

_core_check_pull() {
    if [ "${1:-''}" = "-h" ];then
      >&2 cat << EOF
"$(basename "${0}")" pull -- Information

Usage:
> "$(basename "${0}")" pull [-h]
This will pull all remote changes to the projects and apply them locally.

Note:
The default branch used to fetch from is master, if you need to change this
please see "$(basename "${0}")" set -h

EOF
      exit 0
    fi
  set -e
  git submodule init
  git pull --recurse-submodules
  git submodule update --recursive --remote -j 10 "$@" | sed -e 's/^/\[GIT\]/g'
}
