#!/usr/bin/env bash
# file: bash-util-lib-test.sh

# shellcheck source=bash-util-lib.sh
. ./bash-util-lib.sh

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

setES_USE() {
    local SET_VALUE="$1"

    case "${SET_VALUE}" in
        true)
            ES_USE=true
            assertTrue 'ES_USE environment variable was not turned on' "${ES_USE}"
            ;;

        false|*)
            ES_USE=false
            assertFalse 'ES_USE environment variable was not turned off' "${ES_USE}"
            ;;
    esac
}

setNC_USE() {
    local SET_VALUE="$1"

    case "${SET_VALUE}" in
        true)
            NC_USE=true
            assertTrue 'NC_USE environment variable was not turned on' "${NC_USE}"
            ;;

        false|*)
            NC_USE=false
            assertFalse 'NC_USE environment variable was not turned off' "${NC_USE}"
            ;;
    esac
}


################
# Function: es #
################

test_es_envVarTurnedOnByDefault() {
    assertTrue 'ES_USE environment variable not set to true by default' "${ES_USE}"
}

test_es_controlCode() {
    TEST_OUTPUT="$(es '38;5;1m')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")" \
        "${TEST_OUTPUT}"
}

test_es_envVarTurnedOff() {
    setES_USE false

    TEST_OUTPUT="$(es '38;5;1m')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertNull 'es function should not return output' "${TEST_OUTPUT}"

    setES_USE true
}


################
# Function: nc #
################

test_nc_envVarTurnedOnByDefault() {
    assertTrue 'NC_USE environment variable not set to true by default' \
        "${NC_USE}"
}

test_nc_controlCode() {
    TEST_OUTPUT="$(nc 'setaf' '1')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'nc function not returning correct control sequence' \
        "$(tput setaf 1)" \
        "${TEST_OUTPUT}"
}

test_nc_envVarTurnedOff() {
    setNC_USE false

    TEST_OUTPUT="$(nc 'setaf' '1')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertNull 'nc function should not return output' "${TEST_OUTPUT}"

    setNC_USE true
}

test_nc_cmdTputEmpty() {
    CMD_TPUT=""

    assertNull 'CMD_TPUT environment variable not empty' "${CMD_TPUT}"

    TEST_OUTPUT="$(nc 'setaf' '1')"
    TEST_RETURN_CODE="$?"

    assertFalse 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertNull 'nc function should not return output' "${TEST_OUTPUT}"

    CMD_TPUT="$(which tput)"

    assertNotNull 'CMD_TPUT environment variable empty' "${CMD_TPUT}"
}


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
    TEST_OUTPUT="$(function_exists 'nonExist')"
    TEST_RETURN_CODE="$?"

    assertFalse 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"
}

test_function_exists_exists() {
    local FN_NAME="${FUNCNAME[0]}"
    TEST_OUTPUT="$(function_exists "${FN_NAME}")"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"
}


# Load and run shUnit2
. shunit2
