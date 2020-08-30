#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" ; pwd -P)
PROJECT_ROOT="${SCRIPT_DIR}"
APP=libressl

goal_build() {
  pushd "${SCRIPT_DIR}" > /dev/null
      docker build -t ${APP}  .
      docker tag ${APP} ${APP}:$(cat libressl-version.txt)
  popd > /dev/null
}

goal_run() {
  pushd "${SCRIPT_DIR}" > /dev/null
    docker run -it \
      --name ${APP} \
      ${APP}:$(cat libressl-version.txt) bash
  popd > /dev/null
}

TARGET=${1:-}
if type -t "goal_${TARGET}" &>/dev/null; then
  "goal_${TARGET}" ${@:2}
else
  echo "Usage: $0 <goal>

goal:
    build                   - Builds container
    run                     - Runs container
"
  exit 1
fi
