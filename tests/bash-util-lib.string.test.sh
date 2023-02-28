#!/usr/bin/env bash
# file: bash-util-lib.string.test.sh

# shellcheck disable=SC2016 # Expressions don't expand in single quotes, use double quotes for that.
# shellcheck disable=SC2119 # Use foo "$@" if function's $1 should mean script's $1.
# shellcheck disable=SC2317 # Command appears to be unreachable. Check usage (or ignore if invoked indirectly).


TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"

# shellcheck source=../src/bash-util-lib.string.sh
. "${SOURCE_DIR}/bash-util-lib.string.sh"

# shellcheck source=./shunit2.suite
. "${TESTS_DIR}/shunit2.suite"

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

    assertCommandReturnSuccess

    assertCommandOutputContains 'string_expand not returning the correct content' \
        "${TEMPLATE_TEXT}"

    assertCommandOutputContains 'string_expand not returning the correct content' \
        "${NAME}"
}

test_string_expand_emptyString() {
    commandTest "string_expand ''"

    assertCommandReturnFailure

    assertCommandOutputNull 'string_expand not returning the correct content'
}


##########################
# Function: string_lower #
##########################

test_string_lower_withAllUppercaseLetters() {
    local OUTPUT

    OUTPUT="$(string_lower "UPPERCASE")"

    assertEquals 'string_lower not returning correct output' \
        'uppercase' \
        "${OUTPUT}"
}

test_string_lower_withMixedCaseLetters() {
    local OUTPUT

    OUTPUT="$(string_lower "MiXeD CaSe")"

    assertEquals 'string_lower not returning correct output' \
        'mixed case' \
        "${OUTPUT}"
}

test_string_lower_withAllLowercaseLetters() {
    local OUTPUT

    OUTPUT="$(string_lower "lowercase")"

    assertEquals 'string_lower not returning correct output' \
        'lowercase' \
        "${OUTPUT}"
}


##########################
# Function: string_upper #
##########################

test_string_upper_withAllLowercaseLetters() {
    local OUTPUT

    OUTPUT="$(string_upper "lowercase")"

    assertEquals 'string_upper not returning correct output' \
        'LOWERCASE' \
        "${OUTPUT}"
}

test_string_upper_withMixedCaseLetters() {
    local OUTPUT

    OUTPUT="$(string_upper "MiXeD CaSe")"

    assertEquals 'string_upper not returning correct output' \
        'MIXED CASE' \
        "${OUTPUT}"
}

test_string_upper_withAllUppercaseLetters() {
    local OUTPUT

    OUTPUT="$(string_upper "UPPERCASE")"

    assertEquals 'string_upper not returning correct output' \
        'UPPERCASE' \
        "${OUTPUT}"
}


###########################
# Function: string_repeat #
###########################

test_string_repeat_withStringNotSpecified() {
    local OUTPUT

    OUTPUT="$(string_repeat 2)"

    assertEquals 'string_repeat not returning correct output' \
    '  ' \
    "${OUTPUT}"
}

test_string_repeat_withStringEmpty() {
    local OUTPUT

    OUTPUT="$(string_repeat 2 '')"

    assertEquals 'string_repeat not returning correct output' \
    '' \
    "${OUTPUT}"
}

test_string_repeat_withCountZero() {
    local OUTPUT

    OUTPUT="$(string_repeat 0 'WOW')"

    assertEquals 'string_repeat not returning correct output' \
    '' \
    "${OUTPUT}"
}

test_string_repeat() {
    local OUTPUT

    OUTPUT="$(string_repeat 2 'WOW ')"

    assertEquals 'string_repeat not returning correct output' \
    'WOW WOW ' \
    "${OUTPUT}"
}


###########################
# Function: preface_lines #
###########################

test_preface_lines() {
    local PREFACE='--> '
    local LINE1='Line 1'
    local LINE2='Line 2'
    
    commandTest "preface_lines '${PREFACE}' '$(echo "${LINE1}"; echo "${LINE2}")'"

    assertCommandReturnSuccess

    assertCommandOutputContains 'preface_lines not returning correct formatting' \
        "${PREFACE}${LINE1}"

    assertCommandOutputContains 'preface_lines not returning correct formatting' \
        "${PREFACE}${LINE2}"
}


# Load and run shUnit2
. shunit2
