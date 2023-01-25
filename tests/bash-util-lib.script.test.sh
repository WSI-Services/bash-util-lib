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


###########
# Helpers #
###########

EXPECTED_EXIT_CODE=0

trap_exit() {
    CAPTURED_EXIT_CODE="$?"

    assertEquals 'EXIT called, code not correct' \
        "${EXPECTED_EXIT_CODE}" \
        "${CAPTURED_EXIT_CODE}"
}

trap trap_exit EXIT


######################
# Function: exit_err #
######################

test_exit_err_basic() {
    local ERR_CODE=123
    local ERR_MSG='Test error message'

    EXPECTED_EXIT_CODE="${ERR_CODE}"

    TEST_OUTPUT="$(exit_err "${ERR_CODE}" "${ERR_MSG}" 2>&1 > /dev/null)"

    assertEquals 'exit_err message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}")" \
        "${TEST_OUTPUT}"
}

test_exit_err_additionalMessage() {
    local ERR_CODE=124
    local ERR_MSG='Test error message'
    local ADD_MSG='Test additional message'

    EXPECTED_EXIT_CODE="${ERR_CODE}"

    TEST_OUTPUT="$(exit_err "${ERR_CODE}" "${ERR_MSG}" "${ADD_MSG}" 2>&1)"

    assertEquals 'exit_err message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}"; printf "${EXIT_ERR_MSG_ADDITIONAL}" "${ADD_MSG}")" \
        "${TEST_OUTPUT}"
}

test_exit_err_utilScriptCmd() {
    local ERR_CODE=125
    local ERR_MSG='Test error message'

    EXPECTED_EXIT_CODE="${ERR_CODE}"

    UTIL_SCRIPT_CMD='/path/to/cmd --flag option'

    TEST_OUTPUT="$(exit_err "${ERR_CODE}" "${ERR_MSG}" 2>&1 > /dev/null)"

    assertEquals 'exit_err message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}"; printf "${EXIT_ERR_MSG_COMMAND}" "${UTIL_SCRIPT_CMD}")" \
        "${TEST_OUTPUT}"

    UTIL_SCRIPT_CMD=''
}

test_exit_err_additionalMessageUtilScriptCmd() {
    local ERR_CODE=126
    local ERR_MSG='Test error message'
    local ADD_MSG='Test additional message'

    EXPECTED_EXIT_CODE="${ERR_CODE}"

    UTIL_SCRIPT_CMD='/path/to/new_cmd --flag optionB'

    TEST_OUTPUT="$(exit_err "${ERR_CODE}" "${ERR_MSG}" "${ADD_MSG}" 2>&1)"

    assertEquals 'exit_err message not as expected' \
        "$(printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}"; printf "${EXIT_ERR_MSG_COMMAND}" "${UTIL_SCRIPT_CMD}"; printf "${EXIT_ERR_MSG_ADDITIONAL}" "${ADD_MSG}")" \
        "${TEST_OUTPUT}"

    UTIL_SCRIPT_CMD=''
}


#############################
# Function: function_exists #
#############################

test_function_exists_nonExist() {
    commandTest "function_exists 'nonExist'"

    assertCommandReturnFalse
}

test_function_exists_exists() {
    local FN_NAME="${FUNCNAME[0]}"

    commandTest "function_exists '${FN_NAME}'"

    assertCommandReturnTrue
}


################################
# Function: process_parameters #
################################

PROCESS_ARGS_RETURN=0
PROCESS_OPTS_RETURN=0

helper_processArgsEmpty() {
    return "${PROCESS_ARGS_RETURN}"
}

helper_processOptsEmpty() {
    return "${PROCESS_OPTS_RETURN}"
}

test_process_parameters_missingArgFn() {
    commandTest "process_parameters 'nonExist'"

    assertCommandReturnFalse
}

test_process_parameters_missingOptFn() {
    commandTest "process_parameters 'helper_processArgsEmpty' 'nonExist'"

    assertCommandReturnEquals 2
}

test_process_parameters_fnReturnValue() {
    PROCESS_OPTS_RETURN=123

    commandTest "process_parameters 'helper_processArgsEmpty' 'helper_processOptsEmpty'"

    assertCommandReturnEquals "${PROCESS_OPTS_RETURN}"

    PROCESS_OPTS_RETURN=0
}

test_process_parameters_empty() {
    commandTest "process_parameters 'helper_processArgsEmpty' 'helper_processOptsEmpty'"

    assertCommandReturnTrue
}

ARGS_DETAILS=""

helper_processArgsTest() {
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

helper_processOptsTest() {
    export OPTS_DETAILS="$*"
    return $#
}

test_process_parameters_extraShift() {
    process_parameters 'helper_processArgsTest' 'helper_processOptsTest' -a=A1 --add=B2 -a

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

test_process_parameters_shift() {
    process_parameters 'helper_processArgsTest' 'helper_processOptsTest' -a=A1 --add=B2 -d -a C3 --add D4 --del -- what

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


# Load and run shUnit2
. shunit2
