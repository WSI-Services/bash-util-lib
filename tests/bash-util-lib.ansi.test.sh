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

test_es_color_defaultFgBg() {
    commandTest "es_color '1'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"
}

test_es_color_foreground() {
    commandTest "es_color '1' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[38;5;1m")"
}

test_es_color_background() {
    commandTest "es_color '1' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[48;5;1m")"

    commandTest "es_color '1' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "$(printf "\x1b[48;5;1m")"

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

test_es_color_rgb_defaultFgBg() {
    commandTest "es_color_rgb '255' '127' '127'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_rgb_foreground() {
    commandTest "es_color_rgb '255' '127' '127' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_rgb_background() {
    commandTest "es_color_rgb '255' '127' '127' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"

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

test_es_color_hex_defaultFgBg() {
    commandTest "es_color_hex 'ff7f7f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_hex_foreground() {
    commandTest "es_color_hex 'ff7f7f' ''"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'f'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'F'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'Foreground'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[38;2;255;127;127m")"
}

test_es_color_hex_background() {
    commandTest "es_color_hex 'ff7f7f' 'b'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'B'"

    assertCommandReturnTrue

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "$(printf "\x1b[48;2;255;127;127m")"

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

test_es_attrib_defaultCode() {
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

    TPUT_STRING="$(tput setaf 192)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"
}

test_nc_color_hex_foreground() {
    commandTest "nc_color_hex 'c7ff7c' ''"

    TPUT_STRING="$(tput setaf 192)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"

    commandTest "nc_color_hex 'ffffff' 'f'"

    TPUT_STRING="$(tput setaf 231)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"

    commandTest "nc_color_hex '000000' 'F'"

    TPUT_STRING="$(tput setaf 14)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"

    commandTest "nc_color_hex 'ffffff' 'Foreground'"

    TPUT_STRING="$(tput setaf 231)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"
}

test_nc_color_hex_background() {
    commandTest "nc_color_hex 'ffffff' 'b'"

    TPUT_STRING="$(tput setab 231)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"

    commandTest "nc_color_hex '000000' 'B'"

    TPUT_STRING="$(tput setab 14)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"

    commandTest "nc_color_hex 'ffffff' 'Background'"

    TPUT_STRING="$(tput setab 231)"

    assertCommandReturnTrue

    assertCommandOutputEquals 'nc_color_hex function not returning correct control sequence' \
        "${TPUT_STRING}"
}

test_nc_color_hex_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_color_hex 'ff7f7f'"

    assertCommandReturnFalse

    assertCommandOutputNull 'nc_color_hex function should not return output'

    setNC_USE true
}


# Load and run shUnit2
. shunit2
