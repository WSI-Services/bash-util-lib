#!/usr/bin/env bash
# file: bash-util-lib.script.test.sh

# shellcheck disable=SC2059 # Don't use variables in the printf format string.
# shellcheck disable=SC2119 # Use foo "$@" if function's $1 should mean script's $1.
# shellcheck disable=SC2317 # Command appears to be unreachable. Check usage (or ignore if invoked indirectly).


TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"

# shellcheck source=../src/bash-util-lib.script.sh
. "${SOURCE_DIR}/bash-util-lib.script.sh"

# shellcheck source=./shunit2.assert.command-test
. "${TESTS_DIR}/shunit2.assert.command-test"


#############################
# Function: script::exitErr #
#############################

function test::script::exitErr::withNoAdditionalMessageOrUtilityScriptCommand() {
    local ERR_CODE=123
    local ERR_MSG='Test error message'

    TEST_OUTPUT="$(script::exitErr "${ERR_CODE}" "${ERR_MSG}" 2>&1 > /dev/null)"

    assertEquals 'script::exitErr EXIT called, code not correct' \
        "${ERR_CODE}" \
        "$?"

    assertEquals 'script::exitErr message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}")" \
        "${TEST_OUTPUT}"
}

function test::script::exitErr::withAdditionalMessage() {
    local ERR_CODE=124
    local ERR_MSG='Test error message'
    local ADD_MSG='Test additional message'

    TEST_OUTPUT="$(script::exitErr "${ERR_CODE}" "${ERR_MSG}" "${ADD_MSG}" 2>&1)"

    assertEquals 'script::exitErr EXIT called, code not correct' \
        "${ERR_CODE}" \
        "$?"

    assertEquals 'script::exitErr message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}"; printf "${EXIT_ERR_MSG_ADDITIONAL}" "${ADD_MSG}")" \
        "${TEST_OUTPUT}"
}

function test::script::exitErr::withUtilityScriptCommand() {
    local ERR_CODE=125
    local ERR_MSG='Test error message'

    UTIL_SCRIPT_CMD='/path/to/cmd --flag option'

    TEST_OUTPUT="$(script::exitErr "${ERR_CODE}" "${ERR_MSG}" 2>&1 > /dev/null)"

    assertEquals 'script::exitErr EXIT called, code not correct' \
        "${ERR_CODE}" \
        "$?"

    assertEquals 'script::exitErr message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}"; printf "${EXIT_ERR_MSG_COMMAND}" "${UTIL_SCRIPT_CMD}")" \
        "${TEST_OUTPUT}"

    UTIL_SCRIPT_CMD=''
}

function test::script::exitErr::withAdditionalMessageAndUtilityScriptCommand() {
    local ERR_CODE=126
    local ERR_MSG='Test error message'
    local ADD_MSG='Test additional message'

    UTIL_SCRIPT_CMD='/path/to/new_cmd --flag optionB'

    TEST_OUTPUT="$(script::exitErr "${ERR_CODE}" "${ERR_MSG}" "${ADD_MSG}" 2>&1)"

    assertEquals 'script::exitErr EXIT called, code not correct' \
        "${ERR_CODE}" \
        "$?"

    assertEquals 'script::exitErr message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}"; printf "${EXIT_ERR_MSG_COMMAND}" "${UTIL_SCRIPT_CMD}"; printf "${EXIT_ERR_MSG_ADDITIONAL}" "${ADD_MSG}")" \
        "${TEST_OUTPUT}"

    UTIL_SCRIPT_CMD=''
}


####################################
# Function: script::functionExists #
####################################

function test::script::functionExists::withNonExistentFunction() {
    commandTest "script::functionExists 'nonExist'"

    assertCommandReturnFailure
}

function test::script::functionExists::withExistentFunction() {
    local FN_NAME="${FUNCNAME[0]}"

    commandTest "script::functionExists '${FN_NAME}'"

    assertCommandReturnSuccess
}


#######################################
# Function: script::processParameters #
#######################################

PROCESS_ARGS_RETURN=0
PROCESS_OPTS_RETURN=0

function helper::processArgsEmpty() {
    return "${PROCESS_ARGS_RETURN}"
}

function helper::processOptsEmpty() {
    return "${PROCESS_OPTS_RETURN}"
}

function test::script::processParameters::withMissingArgumentsFunction() {
    commandTest "script::processParameters 'nonExist'"

    assertCommandReturnFailure
}

function test::script::processParameters::withMissingOptionsFunction() {
    commandTest "script::processParameters 'helper::processArgsEmpty' 'nonExist'"

    assertCommandReturnEquals 2
}

function test::script::processParameters::withFunctionReturnValue() {
    PROCESS_OPTS_RETURN=123

    commandTest "script::processParameters 'helper::processArgsEmpty' 'helper::processOptsEmpty'"

    assertCommandReturnEquals "${PROCESS_OPTS_RETURN}"

    PROCESS_OPTS_RETURN=0
}

function test::script::processParameters::withEmptyParameters() {
    commandTest "script::processParameters 'helper::processArgsEmpty' 'helper::processOptsEmpty'"

    assertCommandReturnSuccess
}

ARGS_DETAILS=""

function helper::processArgsTest() {
    ARG1="$1"
    POS_ARG=""
    SHIFT_COUNT=0

    if [[ "${PASS_ARGS}" -gt 0 ]]; then
        POS_ARG="${ARG1}"
        SHIFT_COUNT=$((SHIFT_COUNT+1))
    else
        case "${ARG1}" in
            -a=*|--add=*) # display details for equals-separated option value
                export ARGS_DETAILS="${ARGS_DETAILS}${ARGS_DETAILS:+ }${ARG1#*=}"
                SHIFT_COUNT=$((SHIFT_COUNT+1))
                ;;
            -a|--add)     # display details for space-separated option value
                export ARGS_DETAILS="${ARGS_DETAILS}${ARGS_DETAILS:+ }$2"
                SHIFT_COUNT=$((SHIFT_COUNT+2))
                ;;
            --)           # pass following arguments
                export PASS_ARGS=1
                POS_ARG="${ARG1}"
                SHIFT_COUNT=$((SHIFT_COUNT+1))
                ;;
            *)            # unknown argument
                POS_ARG="${ARG1}"
                SHIFT_COUNT=$((SHIFT_COUNT+1))
                ;;
        esac
    fi

    if [[ -n "${POS_ARG}" ]]; then
        # save argument in an array for later
        export UTIL_PARAM_POSITIONAL="${UTIL_PARAM_POSITIONAL}${UTIL_PARAM_POSITIONAL:+${UTIL_ARRAY_SEPARATOR}}${POS_ARG}"
    fi

    return "${SHIFT_COUNT}"
}

OPTS_DETAILS=""

function helper::processOptsTest() {
    export OPTS_DETAILS="$*"
    return $#
}

function test::script::processParameters::withExtraShift() {
    script::processParameters 'helper::processArgsTest' 'helper::processOptsTest' -a=A1 --add=B2 -a

    TEST_RETURN_CODE="$?"

    assertEquals 'Return Code not returned correctly' \
        0 \
        "${TEST_RETURN_CODE}"

    assertEquals 'Arguments not processed correctly' \
        'A1 B2 ' \
        "${ARGS_DETAILS}"

    ARGS_DETAILS=''

    assertEquals 'Options not collecting correctly' \
        '' \
        "${OPTS_DETAILS}"

    OPTS_DETAILS=''
}

function test::script::processParameters::withShift() {
    script::processParameters 'helper::processArgsTest' 'helper::processOptsTest' -a=A1 --add=B2 -d -a C3 --add D4 --del -- what

    TEST_RETURN_CODE="$?"

    assertEquals 'Return Code not returned correctly' \
        4 \
        "${TEST_RETURN_CODE}"

    assertEquals 'Arguments not processed correctly' \
        'A1 B2 C3 D4' \
        "${ARGS_DETAILS}"

    ARGS_DETAILS=''

    assertEquals 'Options not collecting correctly' \
        '-d --del -- what' \
        "${OPTS_DETAILS}"

    OPTS_DETAILS=''
}
