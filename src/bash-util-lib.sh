#!/usr/bin/env bash

# @file  Bash-Util-Lib
# @brief Bash Utility Library

SOURCE_DIR="$(dirname "${BASH_SOURCE[0]}")"

for FILE in "${SOURCE_DIR}"/bash-util-lib.*.sh; do
    # shellcheck source=/dev/null
    source "${FILE}"
done
