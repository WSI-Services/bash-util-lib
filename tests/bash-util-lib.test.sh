#!/usr/bin/env bash
# file: bash-util-lib.test.sh

TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"

for FILE in "${TESTS_DIR}"/bash-util-lib.*.test.sh; do
    # shellcheck source=/dev/null
    "${FILE}"
done
