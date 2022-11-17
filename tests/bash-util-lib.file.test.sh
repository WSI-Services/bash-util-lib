#!/usr/bin/env bash
# file: bash-util-lib.file.test.sh

TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"

# shellcheck source=../src/bash-util-lib.file.sh
. "${SOURCE_DIR}/bash-util-lib.file.sh"
# shellcheck source=../src/bash-util-lib.string.sh
. "${SOURCE_DIR}/bash-util-lib.string.sh"

# shellcheck source=./shunit2.assert.command-test
. "${TESTS_DIR}/shunit2.assert.command-test"


############################
# Function: file_find_line #
############################

test_file_find_line() {
    local FN_LINE="$((LINENO - 1))"
    local FN_NAME="${FUNCNAME[0]}"
    local FILE="${BASH_SOURCE[0]}"

    commandTest "file_find_line '${FILE}' '^${FN_NAME}() {$'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'file_find_line not returning the correct line number' \
        "${FN_LINE}"
}


############################
# Function: file_get_lines #
############################

test_file_get_lines() {
    local START_LINE="${LINENO}"
    local FILE="${BASH_SOURCE[0]}"
    local STOP_LINE="${LINENO}"

    commandTest "file_get_lines '${FILE}' '${START_LINE}' '${STOP_LINE}'"

    assertCommandReturnTrue

    assertCommandOutputContains 'file_get_lines not returning the start line content' \
        'local START_LINE="${LINENO}"'

    assertCommandOutputContains 'file_get_lines not returning the inner content' \
        'local FILE="${BASH_SOURCE[0]}"'

    assertCommandOutputContains 'file_get_lines not returning the stop line content' \
        'local STOP_LINE="${LINENO}"'
}


###############################
# Function: file_expand_lines #
###############################

test_file_expand_lines() {
    local FILE="${BASH_SOURCE[0]}"
    local START_PATTERN="### Start Pattern Text ###"
    local TEST='$NAME'
    local STOP_PATTERN="### Stop Pattern Text ###"
    local NAME='Test Name'

    commandTest "file_expand_lines '${FILE}' '${START_PATTERN}' '${STOP_PATTERN}'"

    assertCommandReturnTrue

    assertCommandOutputNotContains 'file_expand_lines returning the start pattern content' \
        "local START_PATTERN=\"${START_PATTERN}\""

    assertCommandOutputContains 'file_expand_lines not returning the middle content' \
        "local TEST='${NAME}'"

    assertCommandOutputNotContains 'file_expand_lines returning the stop patter content' \
        "local STOP_PATTERN=\"${STOP_PATTERN}\""
}


############################
# Function: grab_text_blob #
############################

read -r TEXT_BLOB <<TEST_BLOB_NAME_1
Test $(printf 'Data'): ${EXPAND}
TEST_BLOB_NAME_1

test_grab_text_blob() {
    local FILE="${BASH_SOURCE[0]}"
    local EXPAND='abc123'

    commandTest "grab_text_blob '${FILE}' 'TEST_BLOB_NAME_1'"

    assertCommandReturnTrue

    assertCommandOutputContains 'grab_text_blob not returning the correct content' \
        "Test Data: ${EXPAND}"
}


# Load and run shUnit2
. shunit2
