#!/usr/bin/env bash
# file: bash-util-lib.ansi.test.sh

# shellcheck disable=SC2119 # Use foo "$@" if function's $1 should mean script's $1.
# shellcheck disable=SC2317 # Command appears to be unreachable. Check usage (or ignore if invoked indirectly).


TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"
TPUT_SETAF_STRING="$(tput setaf 1)"
TPUT_SETAB_STRING="$(tput setab 1)"

# shellcheck source=../src/bash-util-lib.ansi.sh
. "${SOURCE_DIR}/bash-util-lib.ansi.sh"

# shellcheck source=./shunit2.assert.command-test
. "${TESTS_DIR}/shunit2.assert.command-test"


###########
# Helpers #
###########

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
        "$(printf "\x1b[38;5;1m")"
}

test_es_envVarTurnedOff() {
    setES_USE false

    commandTest "es '38;5;1m'"

    assertCommandReturnFalse

    assertCommandOutputNull 'es function should not return output'

    setES_USE true
}


######################
# Function: es_color #
######################

test_es_color_fgBgNotSpecified() {
    commandTest "es_color '1'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"
}

test_es_color_fgBgEmpty() {
    commandTest "es_color '1' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"
}

test_es_color_fgBgLowerCaseF() {
    commandTest "es_color '1' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"
}

test_es_color_fgBgUpperCaseF() {
    commandTest "es_color '1' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"
}

test_es_color_fgBgForeground() {
    commandTest "es_color '1' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"
}

test_es_color_fgBgLowerCaseB() {
    commandTest "es_color '1' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[48;5;1m")"
}

test_es_color_fgBgUpperCaseB() {
    commandTest "es_color '1' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[48;5;1m")"
}

test_es_color_fgBgBackground() {
    commandTest "es_color '1' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[48;5;1m")"
}

test_es_color_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color '1'"

    assertCommandReturnFalse

    assertCommandOutputNull 'es_color function should not return output'

    setES_USE true
}


##########################
# Function: es_color_rgb #
##########################

test_es_color_rgb_fgBgNotSpecified() {
    commandTest "es_color_rgb '255' '127' '127'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_rgb_fgBgEmpty() {
    commandTest "es_color_rgb '255' '127' '127' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_rgb_fgBgLowerCaseF() {
    commandTest "es_color_rgb '255' '127' '127' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_rgb_fgBgUpperCaseF() {
    commandTest "es_color_rgb '255' '127' '127' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_rgb_fgBgForeground() {
    commandTest "es_color_rgb '255' '127' '127' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_rgb_fgBgLowerCaseB() {
    commandTest "es_color_rgb '255' '127' '127' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"
}

test_es_color_rgb_fgBgUpperCaseB() {
    commandTest "es_color_rgb '255' '127' '127' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"
}

test_es_color_rgb_fgBgBackground() {
    commandTest "es_color_rgb '255' '127' '127' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"
}

test_es_color_rgb_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color_rgb '255' '127' '127'"

    assertCommandReturnFalse

    assertCommandOutputNull 'es_color_rgb function should not return output'

    setES_USE true
}


##########################
# Function: es_color_hex #
##########################

test_es_color_hex_fgBgNotSpecified() {
    commandTest "es_color_hex 'ff7f7f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_hex_fgBgEmpty() {
    commandTest "es_color_hex 'ff7f7f' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_hex_fgBgLowerCaseF() {
    commandTest "es_color_hex 'ff7f7f' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_hex_fgBgUpperCaseF() {
    commandTest "es_color_hex 'ff7f7f' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_hex_fgBgForeground() {
    commandTest "es_color_hex 'ff7f7f' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_hex_fgBgLowerCaseB() {
    commandTest "es_color_hex 'ff7f7f' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"
}

test_es_color_hex_fgBgUpperCaseB() {
    commandTest "es_color_hex 'ff7f7f' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"
}

test_es_color_hex_fgBgBackground() {
    commandTest "es_color_hex 'ff7f7f' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"
}

test_es_color_hex_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color_hex 'ff7f7f'"

    assertCommandReturnFalse

    assertCommandOutputNull 'es_color_hex function should not return output'

    setES_USE true
}


#######################
# Function: es_attrib #
#######################

test_es_attrib_controlCodeNotSpecified() {
    commandTest "es_attrib"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[0m")"
}

test_es_attrib_reset() {
    commandTest "es_attrib 'reset'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[0m")"

    commandTest "es_attrib 0"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[0m")"

    commandTest "es_attrib 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[0m")"
}

test_es_attrib_bold() {
    commandTest "es_attrib 'bold'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[1m")"

    commandTest "es_attrib 1"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[1m")"
}

test_es_attrib_faint() {
    commandTest "es_attrib 'faint'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[2m")"

    commandTest "es_attrib 2"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[2m")"
}

test_es_attrib_italic() {
    commandTest "es_attrib 'italic'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[3m")"

    commandTest "es_attrib 3"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[3m")"
}

test_es_attrib_underline() {
    commandTest "es_attrib 'underline'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[4m")"

    commandTest "es_attrib 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[4m")"
}

test_es_attrib_blink() {
    commandTest "es_attrib 'blink'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[5m")"

    commandTest "es_attrib 5"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[5m")"

    commandTest "es_attrib 6"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[5m")"
}

test_es_attrib_swap() {
    commandTest "es_attrib 'swap'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[7m")"

    commandTest "es_attrib 7"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[7m")"
}

test_es_attrib_hidden() {
    commandTest "es_attrib 'hidden'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[8m")"

    commandTest "es_attrib 8"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[8m")"
}

test_es_attrib_strike() {
    commandTest "es_attrib 'strike'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[9m")"

    commandTest "es_attrib 9"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "$(printf "\x1b[9m")"
}

test_es_attrib_envVarTurnedOff() {
    setES_USE false

    commandTest "es_attrib 'clear'"

    assertCommandReturnFalse

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
        "$(printf "\x1b[2J")"
}

test_es_erase_clear() {
    commandTest "es_erase 'clear'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\x1b[2J")"

    commandTest "es_erase 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\x1b[2J")"
}

test_es_erase_top() {
    commandTest "es_erase 'top'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\x1b[1J")"
}

test_es_erase_bottom() {
    commandTest "es_erase 'bottom'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\x1b[0J")"
}

test_es_erase_cur() {
    commandTest "es_erase 'cur'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\x1b[2K")"
}

test_es_erase_sol() {
    commandTest "es_erase 'sol'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\x1b[1K")"
}

test_es_erase_eol() {
    commandTest "es_erase 'eol'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "$(printf "\x1b[0K")"
}

test_es_erase_envVarTurnedOff() {
    setES_USE false

    commandTest "es_erase 'clear'"

    assertCommandReturnFalse

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
        "$(printf "\x1b[H")"
}

test_es_cursor_home() {
    commandTest "es_cursor 'home'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[H")"

    commandTest "es_cursor 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[H")"
}

test_es_cursor_restore() {
    commandTest "es_cursor 'restore'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[u")"
}

test_es_cursor_save() {
    commandTest "es_cursor 'save'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[s")"
}

test_es_cursor_leftDefaultValue() {
    commandTest "es_cursor 'left'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[0D")"
}

test_es_cursor_left() {
    commandTest "es_cursor 'left' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[4D")"
}

test_es_cursor_rightDefaultValue() {
    commandTest "es_cursor 'right'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[0C")"
}

test_es_cursor_right() {
    commandTest "es_cursor 'right' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[4C")"
}

test_es_cursor_downDefaultValue() {
    commandTest "es_cursor 'down'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[0B")"
}

test_es_cursor_down() {
    commandTest "es_cursor 'down' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[4B")"
}

test_es_cursor_upDefaultValue() {
    commandTest "es_cursor 'up'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[0A")"
}

test_es_cursor_up() {
    commandTest "es_cursor 'up' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[4A")"
}

test_es_cursor_absDefaultValue() {
    commandTest "es_cursor 'abs'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[0;0")"
}

test_es_cursor_abs() {
    commandTest "es_cursor 'abs' 3 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "$(printf "\x1b[3;4")"
}

test_es_cursor_envVarTurnedOff() {
    setES_USE false

    commandTest "es_cursor 'home'"

    assertCommandReturnFalse

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
        "${TPUT_SETAF_STRING}"
}

test_nc_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc 'setaf' '1'"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc function should not return output'

    setNC_USE true
}

test_nc_cmdTputEmpty() {
    CMD_TPUT=""

    assertNull 'CMD_TPUT environment variable not empty' "${CMD_TPUT}"

    commandTest "nc 'setaf' '1'"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc function should not return output'

    CMD_TPUT="$(command -v tput)"

    assertNotNull 'CMD_TPUT environment variable empty' "${CMD_TPUT}"
}


######################
# Function: nc_color #
######################

test_nc_color_defaultFgBg() {
    commandTest "nc_color '1'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAF_STRING}"
}

test_nc_color_foreground() {
    commandTest "nc_color '1' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAF_STRING}"

    commandTest "nc_color '1' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAF_STRING}"

    commandTest "nc_color '1' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAF_STRING}"

    commandTest "nc_color '1' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAF_STRING}"
}

test_nc_color_background() {
    commandTest "nc_color '1' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAB_STRING}"

    commandTest "nc_color '1' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAB_STRING}"

    commandTest "nc_color '1' 'Background'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${TPUT_SETAB_STRING}"
}

test_nc_color_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_color '1'"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc_color function should not return output'

    setNC_USE true
}


#######################
# Function: nc_attrib #
#######################

test_nc_attrib_controlCodeNotSpecified() {
    RESULT="$(tput sgr0)"
    commandTest "nc_attrib"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeUnknown() {
    RESULT="$(tput sgr0)"
    commandTest "nc_attrib 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeReset() {
    RESULT="$(tput sgr0)"
    commandTest "nc_attrib 'reset'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeBold() {
    RESULT="$(tput bold)"
    commandTest "nc_attrib 'bold'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeDim() {
    RESULT="$(tput dim)"
    commandTest "nc_attrib 'dim'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeItalic() {
    RESULT="$(tput sitm)"
    commandTest "nc_attrib 'italic'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeUnderlineOff() {
    RESULT="$(tput rmul)"
    commandTest "nc_attrib 'underline-off'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeUnderline() {
    RESULT="$(tput smul)"
    commandTest "nc_attrib 'underline'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeBlink() {
    RESULT="$(tput blink)"
    commandTest "nc_attrib 'blink'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeReverse() {
    RESULT="$(tput rev)"
    commandTest "nc_attrib 'reverse'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeInvisible() {
    RESULT="$(tput invis)"
    commandTest "nc_attrib 'invisible'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeStandoutOff() {
    RESULT="$(tput rmso)"
    commandTest "nc_attrib 'standout-off'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeStandout() {
    RESULT="$(tput smso)"
    commandTest "nc_attrib 'standout'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_attrib"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc_attrib function should not return output'

    setNC_USE true
}


######################
# Function: nc_erase #
######################

test_nc_erase_controlCodeNotSpecified() {
    RESULT="$(tput clear)"
    commandTest "nc_erase"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeUnknown() {
    RESULT="$(tput clear)"
    commandTest "nc_erase 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeClear() {
    RESULT="$(tput clear)"
    commandTest "nc_erase 'clear'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertLinesNoValueSpecified() {
    RESULT="$(tput il 0)"
    commandTest "nc_erase 'il'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertLines() {
    RESULT="$(tput il 4)"
    commandTest "nc_erase 'il' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertCharactersNoValueSpecified() {
    RESULT="$(tput ich 0)"
    commandTest "nc_erase 'ic'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertCharacters() {
    RESULT="$(tput ich 4)"
    commandTest "nc_erase 'ic' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeCharactersNoValueSpecified() {
    RESULT="$(tput ech 0)"
    commandTest "nc_erase 'en'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeCharacters() {
    RESULT="$(tput ech 4)"
    commandTest "nc_erase 'en' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeEndOfScreen() {
    RESULT="$(tput ed)"
    commandTest "nc_erase 'eos'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeEndOfLine() {
    RESULT="$(tput el)"
    commandTest "nc_erase 'eol'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeStartOfLine() {
    RESULT="$(tput el1)"
    commandTest "nc_erase 'sol'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_erase"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc_erase function should not return output'

    setNC_USE true
}


#######################
# Function: nc_cursor #
#######################

test_nc_cursor_controlCodeNotSpecified() {
    RESULT="$(tput home)"
    commandTest "nc_cursor"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeUnknown() {
    RESULT="$(tput home)"
    commandTest "nc_cursor 'anything'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeHome() {
    RESULT="$(tput home)"
    commandTest "nc_cursor 'home'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeAbsolutePositionNoValueSpecified() {
    RESULT="$(tput cup '0;0')"
    commandTest "nc_cursor 'abs'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeAbsolutePosition() {
    RESULT="$(tput cup '3;4')"
    commandTest "nc_cursor 'abs' 3 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeRightNoValueSpecified() {
    RESULT="$(tput cuf 0)"
    commandTest "nc_cursor 'right'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeRight() {
    RESULT="$(tput cuf 4)"
    commandTest "nc_cursor 'right' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeLeftNoValueSpecified() {
    RESULT="$(tput cub 0)"
    commandTest "nc_cursor 'left'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeLeft() {
    RESULT="$(tput cub 4)"
    commandTest "nc_cursor 'left' 4"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeDown() {
    RESULT="$(tput cud1)"
    commandTest "nc_cursor 'down'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeUp() {
    RESULT="$(tput cuu1)"
    commandTest "nc_cursor 'up'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeInvisibleOff() {
    RESULT="$(tput cvvis)"
    commandTest "nc_cursor 'invisible-off'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeInvisible() {
    RESULT="$(tput civis)"
    commandTest "nc_cursor 'invisible'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeRestore() {
    RESULT="$(tput rc)"
    commandTest "nc_cursor 'restore'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeSave() {
    RESULT="$(tput sc)"
    commandTest "nc_cursor 'save'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_cursor"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc_cursor function should not return output'

    setNC_USE true
}


# Load and run shUnit2
. shunit2
