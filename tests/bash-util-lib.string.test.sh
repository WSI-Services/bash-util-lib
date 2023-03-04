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


############################
# Function: string::expand #
############################

function test::string::expand() {
    local STRING='${TEMPLATE_TEXT} : $(printf "Hello %s, how are you" $NAME) : %%%'
    local TEMPLATE_TEXT='Text Template'
    local NAME="Ralph"

    commandTest "string::expand '${STRING}'"

    assertCommandReturnSuccess

    assertCommandOutputContains 'string::expand not returning the correct content' \
        "${TEMPLATE_TEXT}"

    assertCommandOutputContains 'string::expand not returning the correct content' \
        "${NAME}"
}

function test::string::expand::withEmptyString() {
    commandTest "string::expand ''"

    assertCommandReturnFailure

    assertCommandOutputNull 'string::expand not returning the correct content'
}


###########################
# Function: string::lower #
###########################

function test::string::lower::withAllUppercaseLetters() {
    local OUTPUT

    OUTPUT="$(string::lower "UPPERCASE")"

    assertEquals 'string::lower not returning correct output' \
        'uppercase' \
        "${OUTPUT}"
}

function test::string::lower::withMixedCaseLetters() {
    local OUTPUT

    OUTPUT="$(string::lower "MiXeD CaSe")"

    assertEquals 'string::lower not returning correct output' \
        'mixed case' \
        "${OUTPUT}"
}

function test::string::lower::withAllLowercaseLetters() {
    local OUTPUT

    OUTPUT="$(string::lower "lowercase")"

    assertEquals 'string::lower not returning correct output' \
        'lowercase' \
        "${OUTPUT}"
}


###########################
# Function: string::upper #
###########################

function test::string::upper::withAllLowercaseLetters() {
    local OUTPUT

    OUTPUT="$(string::upper "lowercase")"

    assertEquals 'string::upper not returning correct output' \
        'LOWERCASE' \
        "${OUTPUT}"
}

function test::string::upper::withMixedCaseLetters() {
    local OUTPUT

    OUTPUT="$(string::upper "MiXeD CaSe")"

    assertEquals 'string::upper not returning correct output' \
        'MIXED CASE' \
        "${OUTPUT}"
}

function test::string::upper::withAllUppercaseLetters() {
    local OUTPUT

    OUTPUT="$(string::upper "UPPERCASE")"

    assertEquals 'string::upper not returning correct output' \
        'UPPERCASE' \
        "${OUTPUT}"
}


############################
# Function: string::repeat #
############################

function test::string::repeat::withStringNotSpecified() {
    local OUTPUT

    OUTPUT="$(string::repeat 2)"

    assertEquals 'string::repeat not returning correct output' \
    '  ' \
    "${OUTPUT}"
}

function test::string::repeat::withStringEmpty() {
    local OUTPUT

    OUTPUT="$(string::repeat 2 '')"

    assertEquals 'string::repeat not returning correct output' \
    '' \
    "${OUTPUT}"
}

function test::string::repeat::withCountZero() {
    local OUTPUT

    OUTPUT="$(string::repeat 0 'WOW')"

    assertEquals 'string::repeat not returning correct output' \
    '' \
    "${OUTPUT}"
}

function test::string::repeat() {
    local OUTPUT

    OUTPUT="$(string::repeat 2 'WOW ')"

    assertEquals 'string::repeat not returning correct output' \
    'WOW WOW ' \
    "${OUTPUT}"
}


#############################
# Function: string::preface #
#############################

function test::string::preface() {
    local PREFACE='--> '
    local LINE1='Line 1'
    local LINE2='Line 2'

    commandTest "string::preface '${PREFACE}' '$(echo "${LINE1}"; echo "${LINE2}")'"

    assertCommandReturnSuccess

    assertCommandOutputContains 'string::preface not returning correct formatting' \
        "${PREFACE}${LINE1}"

    assertCommandOutputContains 'string::preface not returning correct formatting' \
        "${PREFACE}${LINE2}"
}
