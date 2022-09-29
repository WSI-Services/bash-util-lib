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


######################
# Function: es_color #
######################

test_es_color_defaultFgBg() {
    TEST_OUTPUT="$(es_color '1')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")" \
        "${TEST_OUTPUT}"
}

test_es_color_foreground() {
    TEST_OUTPUT="$(es_color '1' '')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color '1' 'f')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color '1' 'F')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color '1' 'Foreground')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")" \
        "${TEST_OUTPUT}"
}

test_es_color_background() {
    TEST_OUTPUT="$(es_color '1' 'b')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[48;5;1m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color '1' 'B')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[48;5;1m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color '1' 'Background')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[48;5;1m")" \
        "${TEST_OUTPUT}"
}

test_es_color_envVarTurnedOff() {
    setES_USE false

    TEST_OUTPUT="$(es_color '1')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertNull 'es_color function should not return output' "${TEST_OUTPUT}"

    setES_USE true
}


##########################
# Function: es_color_rgb #
##########################

test_es_color_rgb_defaultFgBg() {
    TEST_OUTPUT="$(es_color_rgb '255' '127' '127')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")" \
        "${TEST_OUTPUT}"
}

test_es_color_rgb_foreground() {
    TEST_OUTPUT="$(es_color_rgb '255' '127' '127' '')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color_rgb '255' '127' '127' 'f')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color_rgb '255' '127' '127' 'F')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color_rgb '255' '127' '127' 'Foreground')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")" \
        "${TEST_OUTPUT}"
}

test_es_color_rgb_background() {
    TEST_OUTPUT="$(es_color_rgb '255' '127' '127' 'b')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color_rgb '255' '127' '127' 'B')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")" \
        "${TEST_OUTPUT}"

    OUTPUT="$(es_color_rgb '255' '127' '127' 'Background')"
    CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")" \
        "${TEST_OUTPUT}"
}

test_es_color_rgb_envVarTurnedOff() {
    setES_USE false

    TEST_OUTPUT="$(es_color_rgb '255' '127' '127')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertNull 'es_color_rgb function should not return output' "${TEST_OUTPUT}"

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


############################
# Function: file_find_line #
############################

test_file_find_line() {
    local FN_LINE="$((LINENO - 1))"
    local FN_NAME="${FUNCNAME[0]}"
    local FILE="${BASH_SOURCE[0]}"

    TEST_OUTPUT="$(file_find_line "${FILE}" "^${FN_NAME}() {$")"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertEquals 'file_find_line not returning the correct line number' \
        "${FN_LINE}" \
        "${TEST_OUTPUT}"
}


############################
# Function: file_get_lines #
############################

test_file_get_lines() {
    local START_LINE="${LINENO}"
    local FILE="${BASH_SOURCE[0]}"
    local STOP_LINE="${LINENO}"

    TEST_OUTPUT="$(file_get_lines "${FILE}" "${START_LINE}" "${STOP_LINE}")"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertContains 'file_get_lines not returning the start line content' \
        "${TEST_OUTPUT}" \
        'local START_LINE="${LINENO}"'

    assertContains 'file_get_lines not returning the inner content' \
        "${TEST_OUTPUT}" \
        'local FILE="${BASH_SOURCE[0]}"'

    assertContains 'file_get_lines not returning the stop line content' \
        "${TEST_OUTPUT}" \
        'local STOP_LINE="${LINENO}"'
}


###########################
# Function: string_expand #
###########################

test_string_expand() {
    local STRING='${TEMPLATE_TEXT} : $(printf "Hello %s, how are you" $NAME) : %%%'
    local TEMPLATE_TEXT='Text Template'
    local NAME="Ralph"

    TEST_OUTPUT="$(string_expand "${STRING}")"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertContains 'string_expand not returning the correct content' \
        "${TEST_OUTPUT}" \
        "${TEMPLATE_TEXT}"

    assertContains 'string_expand not returning the correct content' \
        "${TEST_OUTPUT}" \
        "${NAME}"
}

test_string_expand_emptyString() {
    TEST_OUTPUT="$(string_expand '')"
    TEST_RETURN_CODE="$?"

    assertFalse 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertNull 'string_expand not returning the correct content' "${TEST_OUTPUT}"
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

    TEST_OUTPUT="$(file_expand_lines "${FILE}" "${START_PATTERN}" "${STOP_PATTERN}")"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertNotContains 'file_expand_lines returning the start pattern content' \
        "${TEST_OUTPUT}" \
        "local START_PATTERN=\"${START_PATTERN}\""

    assertContains 'file_expand_lines not returning the middle content' \
        "${TEST_OUTPUT}" \
        "local TEST='${NAME}'"

    assertNotContains 'file_expand_lines returning the stop patter content' \
        "${TEST_OUTPUT}" \
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

    TEST_OUTPUT="$(grab_text_blob "${FILE}" "TEST_BLOB_NAME_1")"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"

    assertContains 'grab_text_blob not returning the correct content' \
        "${TEST_OUTPUT}" \
        "Test Data: ${EXPAND}"
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


################################
# Function: process_parameters #
################################

PROCESS_ARGS_RETURN=0
PROCESS_OPTS_RETURN=0

processArgsEmpty() {
    return "${PROCESS_ARGS_RETURN}"
}

processOptsEmpty() {
    return "${PROCESS_OPTS_RETURN}"
}

test_process_parameters_noArgFn() {
    TEST_OUTPUT="$(process_parameters 'nonExist')"
    TEST_RETURN_CODE="$?"

    assertFalse 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"
}

test_process_parameters_noOptFn() {
    TEST_OUTPUT="$(process_parameters 'processArgsEmpty' 'nonExist')"
    TEST_RETURN_CODE="$?"

    assertEquals 'Exit Code not returned correctly' \
        2 \
        "${TEST_RETURN_CODE}"
}

test_process_parameters_fnReturnValue() {
    PROCESS_OPTS_RETURN=123

    TEST_OUTPUT="$(process_parameters 'processArgsEmpty' 'processOptsEmpty')"
    TEST_RETURN_CODE="$?"

    assertEquals 'Exit Code not returned correctly' \
        "${PROCESS_OPTS_RETURN}" \
        "${TEST_RETURN_CODE}"

    PROCESS_OPTS_RETURN=0
}

test_process_parameters_empty() {
    TEST_OUTPUT="$(process_parameters 'processArgsEmpty' 'processOptsEmpty')"
    TEST_RETURN_CODE="$?"

    assertTrue 'Exit Code not returned correctly' "${TEST_RETURN_CODE}"
}

ARGS_DETAILS=""

processArgsTest() {
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

processOptsTest() {
    export OPTS_DETAILS="$*"
    return $#
}

test_process_parameters_shift() {
    process_parameters 'processArgsTest' 'processOptsTest' -a=A1 --add=B2 -d -a C3 --add D4 --del -- what

    TEST_RETURN_CODE="$?"

    assertEquals 'Exit Code not returned correctly' \
        4 \
        "${TEST_RETURN_CODE}"

    assertEquals 'Arguments not processed correctly' \
        'A1 B2 C3 D4' \
        "${ARGS_DETAILS}"

    assertEquals 'Options not collecting correctly' \
        '-d --del -- what' \
        "${OPTS_DETAILS}"
}


# Load and run shUnit2
. shunit2
