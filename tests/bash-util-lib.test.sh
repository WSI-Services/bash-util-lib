#!/usr/bin/env bash
# file: bash-util-lib.test.sh

TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"

"${TESTS_DIR}/bash-util-lib.ansi.test.sh"
"${TESTS_DIR}/bash-util-lib.file.test.sh"
"${TESTS_DIR}/bash-util-lib.script.test.sh"
"${TESTS_DIR}/bash-util-lib.string.test.sh"
