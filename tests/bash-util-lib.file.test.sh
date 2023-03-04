#!/usr/bin/env bash
# file: bash-util-lib.file.test.sh

# shellcheck disable=SC2016 # Expressions don't expand in single quotes, use double quotes for that.
# shellcheck disable=SC2034 # foo appears unused. Verify it or export it.
# shellcheck disable=SC2119 # Use foo "$@" if function's $1 should mean script's $1.
# shellcheck disable=SC2317 # Command appears to be unreachable. Check usage (or ignore if invoked indirectly).


TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"

# shellcheck source=../src/bash-util-lib.file.sh
. "${SOURCE_DIR}/bash-util-lib.file.sh"

# shellcheck source=./shunit2.assert.command-test
. "${TESTS_DIR}/shunit2.assert.command-test"


############################
# Function: file::findLine #
############################

function test::file::findLine() {
    local FN_LINE="$((LINENO - 1))"
    local FN_NAME="${FUNCNAME[0]}"
    local FILE="${BASH_SOURCE[0]}"

    commandTest "file::findLine '${FILE}' '^function ${FN_NAME}() {$'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'file::findLine not returning the correct line number' \
        "${FN_LINE}"
}


############################
# Function: file::getLines #
############################

function test::file::getLines() {
    local START_LINE="${LINENO}"
    local FILE="${BASH_SOURCE[0]}"
    local STOP_LINE="${LINENO}"

    commandTest "file::getLines '${FILE}' '${START_LINE}' '${STOP_LINE}'"

    assertCommandReturnSuccess

    assertCommandOutputContains 'file::getLines not returning the start line content' \
        'local START_LINE="${LINENO}"'

    assertCommandOutputContains 'file::getLines not returning the inner content' \
        'local FILE="${BASH_SOURCE[0]}"'

    assertCommandOutputContains 'file::getLines not returning the stop line content' \
        'local STOP_LINE="${LINENO}"'
}


###############################
# Function: file::expandLines #
###############################

function test::file::expandLines() {
    local FILE="${BASH_SOURCE[0]}"
    local START_PATTERN="### Start Pattern Text ###"
    local TEST='$NAME'
    local STOP_PATTERN="### Stop Pattern Text ###"
    local NAME='Test Name'

    commandTest "file::expandLines '${FILE}' '${START_PATTERN}' '${STOP_PATTERN}'"

    assertCommandReturnSuccess

    assertCommandOutputNotContains 'file::expandLines returning the start pattern content' \
        "local START_PATTERN=\"${START_PATTERN}\""

    assertCommandOutputContains 'file::expandLines not returning the middle content' \
        "local TEST='${NAME}'"

    assertCommandOutputNotContains 'file::expandLines returning the stop patter content' \
        "local STOP_PATTERN=\"${STOP_PATTERN}\""
}


###############################
# Function: file::getTextBlob #
###############################

read -r TEXT_BLOB <<TEST_BLOB_NAME_1
Test $(printf 'Data'): ${EXPAND}
TEST_BLOB_NAME_1

function test::file::getTextBlob() {
    local FILE="${BASH_SOURCE[0]}"
    local EXPAND='abc123'

    commandTest "file::getTextBlob '${FILE}' 'TEST_BLOB_NAME_1'"

    assertCommandReturnSuccess

    assertCommandOutputContains 'file::getTextBlob not returning the correct content' \
        "Test Data: ${EXPAND}"
}
