#!/usr/bin/env bash
# file: bash-util-lib-test.sh

# shellcheck source=bash-util-lib.sh
. ./bash-util-lib.sh

. ./shunit2.assert.command-test

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
    commandTest "es '38;5;1m'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")"
}

test_es_envVarTurnedOff() {
    setES_USE false

    commandTest "es '38;5;1m'"

    assertCommandReturnTrue

    assertCommandOutputNull 'es function should not return output'

    setES_USE true
}


######################
# Function: es_color #
######################

test_es_color_defaultFgBg() {
    commandTest "es_color '1'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")"
}

test_es_color_foreground() {
    commandTest "es_color '1' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")"

    commandTest "es_color '1' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")"

    commandTest "es_color '1' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")"

    commandTest "es_color '1' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[38;5;1m")"
}

test_es_color_background() {
    commandTest "es_color '1' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[48;5;1m")"

    commandTest "es_color '1' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[48;5;1m")"

    commandTest "es_color '1' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\033[48;5;1m")"
}

test_es_color_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color '1'"

    assertCommandReturnTrue

    assertCommandOutputNull 'es_color function should not return output'

    setES_USE true
}


##########################
# Function: es_color_rgb #
##########################

test_es_color_rgb_defaultFgBg() {
    commandTest "es_color_rgb '255' '127' '127'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"
}

test_es_color_rgb_foreground() {
    commandTest "es_color_rgb '255' '127' '127' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"
}

test_es_color_rgb_background() {
    commandTest "es_color_rgb '255' '127' '127' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")"
}

test_es_color_rgb_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color_rgb '255' '127' '127'"

    assertCommandReturnTrue

    assertCommandOutputNull 'es_color_rgb function should not return output'

    setES_USE true
}


##########################
# Function: es_color_hex #
##########################

test_es_color_hex_defaultFgBg() {
    commandTest "es_color_hex 'ff7f7f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"
}

test_es_color_hex_foreground() {
    commandTest "es_color_hex 'ff7f7f' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[38;2;255;127;127m")"
}

test_es_color_hex_background() {
    commandTest "es_color_hex 'ff7f7f' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\033[48;2;255;127;127m")"
}

test_es_color_hex_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color_hex 'ff7f7f'"

    assertCommandReturnTrue

    assertCommandOutputNull 'es_color_hex function should not return output'

    setES_USE true
}


#######################
# Function: es_attrib #
#######################

test_es_attrib_defaultCode() {
    commandTest "es_attrib"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[0m")"
}

test_es_attrib_reset() {
    commandTest "es_attrib 'reset'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[0m")"

    commandTest "es_attrib 0"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[0m")"

    commandTest "es_attrib 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[0m")"
}

test_es_attrib_bold() {
    commandTest "es_attrib 'bold'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[1m")"

    commandTest "es_attrib 1"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[1m")"
}

test_es_attrib_faint() {
    commandTest "es_attrib 'faint'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[2m")"

    commandTest "es_attrib 2"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[2m")"
}

test_es_attrib_italic() {
    commandTest "es_attrib 'italic'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[3m")"

    commandTest "es_attrib 3"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[3m")"
}

test_es_attrib_underline() {
    commandTest "es_attrib 'underline'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[4m")"

    commandTest "es_attrib 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[4m")"
}

test_es_attrib_blink() {
    commandTest "es_attrib 'blink'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[5m")"

    commandTest "es_attrib 5"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[5m")"

    commandTest "es_attrib 6"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[5m")"
}

test_es_attrib_swap() {
    commandTest "es_attrib 'swap'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[7m")"

    commandTest "es_attrib 7"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[7m")"
}

test_es_attrib_hidden() {
    commandTest "es_attrib 'hidden'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[8m")"

    commandTest "es_attrib 8"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[8m")"
}

test_es_attrib_strike() {
    commandTest "es_attrib 'strike'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[9m")"

    commandTest "es_attrib 9"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\033[9m")"
}

test_es_attrib_envVarTurnedOff() {
    setES_USE false

    commandTest "es_attrib 'clear'"

    assertCommandReturnTrue

    assertCommandOutputNull 'es_attrib function should not return output'

    setES_USE true
}


######################
# Function: es_erase #
######################

test_es_erase_defaultCode() {
    commandTest "es_erase"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[2J")"
}

test_es_erase_clear() {
    commandTest "es_erase 'clear'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[2J")"

    commandTest "es_erase 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[2J")"
}

test_es_erase_top() {
    commandTest "es_erase 'top'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[1J")"
}

test_es_erase_bottom() {
    commandTest "es_erase 'bottom'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[0J")"
}

test_es_erase_cur() {
    commandTest "es_erase 'cur'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[2K")"
}

test_es_erase_sol() {
    commandTest "es_erase 'sol'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[1K")"
}

test_es_erase_eol() {
    commandTest "es_erase 'eol'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\033[0K")"
}

test_es_erase_envVarTurnedOff() {
    setES_USE false

    commandTest "es_erase 'clear'"

    assertCommandReturnTrue

    assertCommandOutputNull 'es_erase function should not return output'

    setES_USE true
}


#######################
# Function: es_cursor #
#######################

test_es_cursor_defaultCode() {
    commandTest "es_cursor"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[H")"
}

test_es_cursor_home() {
    commandTest "es_cursor 'home'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[H")"

    commandTest "es_cursor 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[H")"
}

test_es_cursor_restore() {
    commandTest "es_cursor 'restore'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[u")"
}

test_es_cursor_save() {
    commandTest "es_cursor 'save'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[s")"
}

test_es_cursor_leftDefaultValue() {
    commandTest "es_cursor 'left'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[0D")"
}

test_es_cursor_left() {
    commandTest "es_cursor 'left' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[4D")"
}

test_es_cursor_rightDefaultValue() {
    commandTest "es_cursor 'right'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[0C")"
}

test_es_cursor_right() {
    commandTest "es_cursor 'right' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[4C")"
}

test_es_cursor_downDefaultValue() {
    commandTest "es_cursor 'down'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[0B")"
}

test_es_cursor_down() {
    commandTest "es_cursor 'down' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[4B")"
}

test_es_cursor_upDefaultValue() {
    commandTest "es_cursor 'up'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[0A")"
}

test_es_cursor_up() {
    commandTest "es_cursor 'up' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[4A")"
}

test_es_cursor_absDefaultValue() {
    commandTest "es_cursor 'abs'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[0;0")"
}

test_es_cursor_abs() {
    commandTest "es_cursor 'abs' 3 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\033[3;4")"
}

test_es_cursor_envVarTurnedOff() {
    setES_USE false

    commandTest "es_cursor 'home'"

    assertCommandReturnTrue

    assertCommandOutputNull 'es_cursor function should not return output'

    setES_USE true
}


################
# Function: nc #
################

test_nc_envVarTurnedOnByDefault() {
    assertTrue 'NC_USE environment variable not set to true by default' "${NC_USE}"
}

test_nc_controlCode() {
    commandTest "nc 'setaf' '1'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc function not returning correct control sequence' \
        "$(tput setaf 1)"
}

test_nc_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc 'setaf' '1'"

    assertCommandReturnTrue

    assertCommandOutputNull 'nc function should not return output'

    setNC_USE true
}

test_nc_cmdTputEmpty() {
    CMD_TPUT=""

    assertNull 'CMD_TPUT environment variable not empty' "${CMD_TPUT}"

    commandTest "nc 'setaf' '1'"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc function should not return output'

    CMD_TPUT="$(which tput)"

    assertNotNull 'CMD_TPUT environment variable empty' "${CMD_TPUT}"
}


######################
# Function: nc_color #
######################

test_nc_color_defaultFgBg() {
    commandTest "nc_color '1'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setaf 1)"
}

test_nc_color_foreground() {
    commandTest "nc_color '1' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setaf 1)"

    commandTest "nc_color '1' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setaf 1)"

    commandTest "nc_color '1' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setaf 1)"

    commandTest "nc_color '1' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setaf 1)"
}

test_nc_color_background() {
    commandTest "nc_color '1' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setab 1)"

    commandTest "nc_color '1' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setab 1)"

    commandTest "nc_color '1' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "$(tput setab 1)"
}

test_nc_color_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_color '1'"

    assertCommandReturnTrue

    assertCommandOutputNull 'nc_color function should not return output'

    setNC_USE true
}


###############################
# Function: nc_color_from_hex #
###############################

test_nc_color_from_hex_noHex() {
    commandTest "nc_color_from_hex ''"

    assertCommandReturnFalse
}

test_nc_color_from_hex_withColor() {
    commandTest "nc_color_from_hex 'c7ff7c'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_from_hex should return color index code' \
        '192'

    commandTest "nc_color_from_hex 'ffffff'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_from_hex should return color index code' \
        '231'

    commandTest "nc_color_from_hex '000000'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_from_hex should return color index code' \
        '14'
}


##########################
# Function: nc_color_hex #
##########################

test_nc_color_hex_defaultFgBg() {
    commandTest "nc_color_hex 'c7ff7c'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setaf 192)"
}

test_nc_color_hex_foreground() {
    commandTest "nc_color_hex 'c7ff7c' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setaf 192)"

    commandTest "nc_color_hex 'ffffff' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setaf 231)"

    commandTest "nc_color_hex '000000' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setaf 14)"

    commandTest "nc_color_hex 'ffffff' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setaf 231)"
}

test_nc_color_hex_background() {
    commandTest "nc_color_hex 'ffffff' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setab 231)"

    commandTest "nc_color_hex '000000' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setab 14)"

    commandTest "nc_color_hex 'ffffff' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "$(tput setab 231)"
}

test_nc_color_hex_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_color_hex 'ff7f7f'"

    assertCommandReturnTrue

    assertCommandOutputNull 'nc_color_hex function should not return output'

    setNC_USE true
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

processArgsEmpty() {
    return "${PROCESS_ARGS_RETURN}"
}

processOptsEmpty() {
    return "${PROCESS_OPTS_RETURN}"
}

test_process_parameters_noArgFn() {
    commandTest "process_parameters 'nonExist'"

    assertCommandReturnFalse
}

test_process_parameters_noOptFn() {
    commandTest "process_parameters 'processArgsEmpty' 'nonExist'"

    assertCommandReturnEquals 2
}

test_process_parameters_fnReturnValue() {
    PROCESS_OPTS_RETURN=123

    commandTest "process_parameters 'processArgsEmpty' 'processOptsEmpty'"

    assertCommandReturnEquals "${PROCESS_OPTS_RETURN}"

    PROCESS_OPTS_RETURN=0
}

test_process_parameters_empty() {
    commandTest "process_parameters 'processArgsEmpty' 'processOptsEmpty'"

    assertCommandReturnTrue
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

    assertEquals 'Return Code not returned correctly' \
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
