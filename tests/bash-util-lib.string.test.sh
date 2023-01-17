#!/usr/bin/env bash
# file: bash-util-lib.string.test.sh

# shellcheck disable=SC2016 # Expressions don't expand in single quotes, use double quotes for that.
# shellcheck disable=SC2119 # Use foo "$@" if function's $1 should mean script's $1.
# shellcheck disable=SC2317 # Command appears to be unreachable. Check usage (or ignore if invoked indirectly).


TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"

# shellcheck source=../src/bash-util-lib.string.sh
. "${SOURCE_DIR}/bash-util-lib.string.sh"

# shellcheck source=./shunit2.assert.command-test
. "${TESTS_DIR}/shunit2.assert.command-test"


###########################
# Function: string_expand #
###########################

test_string_expand() {
    local STRING='${TEMPLATE_TEXT} : $(printf "Hello %s, how are you" $NAME) : %%%'
    local TEMPLATE_TEXT='Text Template'
    local NAME="Ralph"

    commandTest "string_expand '${STRING}'"

    assertCommandReturnTrue

    assertCommandOutputContains 'string_expand not returning the correct content' \
        "${TEMPLATE_TEXT}"

    assertCommandOutputContains 'string_expand not returning the correct content' \
        "${NAME}"
}

test_string_expand_emptyString() {
    commandTest "string_expand ''"

    assertCommandReturnFalse

    assertCommandOutputNull 'string_expand not returning the correct content'
}


# Load and run shUnit2
. shunit2
