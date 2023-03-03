#!/usr/bin/env bash
# file: bash-util-lib.ansi.test.sh

# shellcheck disable=SC2119 # Use foo "$@" if function's $1 should mean script's $1.
# shellcheck disable=SC2317 # Command appears to be unreachable. Check usage (or ignore if invoked indirectly).


TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"

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
         true) ES_USE=true ;;
        false) ES_USE=false ;;
            *) fail "ES_USE failed to be set: provide 'true' or 'false'"
    esac
}

setNC_USE() {
    local SET_VALUE="$1"

    case "${SET_VALUE}" in
         true) NC_USE=true ;;
        false) NC_USE=false ;;
            *) fail "NC_USE failed to be set: provide 'true' or 'false'"
    esac
}


################
# Function: es #
################

test_es_envVarTurnedOnByDefault() {
    assertTrue 'ES_USE environment variable not set to true by default' "${ES_USE}"
}

test_es_controlCode() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "es '38;5;1m'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es function not returning correct control sequence' \
        "${RESULT}"
}

test_es_envVarTurnedOff() {
    setES_USE false

    commandTest "es '38;5;1m'"

    assertCommandReturnFailure

    assertCommandOutputNull 'es function should not return output'

    setES_USE true
}


######################
# Function: es_color #
######################

test_es_color_roleNotSpecified() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleEmpty() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleLowerCaseF() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleUpperCaseF() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleForeground() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "es_color '1' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleLowerCaseB() {
    RESULT="$(printf "\x1b[48;5;1m")"

    commandTest "es_color '1' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleUpperCaseB() {
    RESULT="$(printf "\x1b[48;5;1m")"

    commandTest "es_color '1' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleBackground() {
    RESULT="$(printf "\x1b[48;5;1m")"

    commandTest "es_color '1' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleLowerCaseU() {
    RESULT="$(printf "\x1b[58;5;1m")"

    commandTest "es_color '1' 'u'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleUpperCaseU() {
    RESULT="$(printf "\x1b[58;5;1m")"

    commandTest "es_color '1' 'U'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_roleUnderline() {
    RESULT="$(printf "\x1b[58;5;1m")"

    commandTest "es_color '1' 'Underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'es_color function should not return output'

    setES_USE true
}


##########################
# Function: es_color_rgb #
##########################

test_es_color_rgb_roleNotSpecified() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleEmpty() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleLowerCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleUpperCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleForeground() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleLowerCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleUpperCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleBackground() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleLowerCaseU() {
    RESULT="$(printf "\x1b[58;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'u'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleUpperCaseU() {
    RESULT="$(printf "\x1b[58;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'U'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_roleUnderline() {
    RESULT="$(printf "\x1b[58;2;255;127;127m")"

    commandTest "es_color_rgb '255' '127' '127' 'Underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_rgb function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_rgb_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color_rgb '255' '127' '127'"

    assertCommandReturnFailure

    assertCommandOutputNull 'es_color_rgb function should not return output'

    setES_USE true
}


##########################
# Function: es_color_hex #
##########################

test_es_color_hex_roleNotSpecified() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_roleEmpty() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_roleLowerCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_roleUpperCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_roleForeground() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_roleLowerCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_roleUpperCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_roleBackground() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "es_color_hex 'ff7f7f' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_color_hex function not returning correct control sequence' \
        "${RESULT}"
}

test_es_color_hex_envVarTurnedOff() {
    setES_USE false

    commandTest "es_color_hex 'ff7f7f'"

    assertCommandReturnFailure

    assertCommandOutputNull 'es_color_hex function should not return output'

    setES_USE true
}


#######################
# Function: es_attrib #
#######################

test_es_attrib_controlCodeNotSpecified() {
    RESULT="$(printf "\x1b[0m")"

    commandTest "es_attrib"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeUnknown() {
    RESULT="$(printf "\x1b[0m")"

    commandTest "es_attrib 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeReset() {
    RESULT="$(printf "\x1b[0m")"

    commandTest "es_attrib 'reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeBold() {
    RESULT="$(printf "\x1b[1m")"

    commandTest "es_attrib 'bold'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeFaint() {
    RESULT="$(printf "\x1b[2m")"

    commandTest "es_attrib 'faint'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeItalic() {
    RESULT="$(printf "\x1b[3m")"

    commandTest "es_attrib 'italic'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeUnderline() {
    RESULT="$(printf "\x1b[4m")"

    commandTest "es_attrib 'underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeBlink() {
    RESULT="$(printf "\x1b[5m")"

    commandTest "es_attrib 'blink'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeFastBlink() {
    RESULT="$(printf "\x1b[6m")"

    commandTest "es_attrib 'fast-blink'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeSwap() {
    RESULT="$(printf "\x1b[7m")"

    commandTest "es_attrib 'swap'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeHidden() {
    RESULT="$(printf "\x1b[8m")"

    commandTest "es_attrib 'hidden'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeStrike() {
    RESULT="$(printf "\x1b[9m")"

    commandTest "es_attrib 'strike'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeOverline() {
    RESULT="$(printf "\x1b[53m")"

    commandTest "es_attrib 'overline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeBoldReset() {
    RESULT="$(printf "\x1b[22m")"

    commandTest "es_attrib 'bold-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeFaintReset() {
    RESULT="$(printf "\x1b[22m")"

    commandTest "es_attrib 'faint-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeItalicReset() {
    RESULT="$(printf "\x1b[23m")"

    commandTest "es_attrib 'italic-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeUnderlineReset() {
    RESULT="$(printf "\x1b[24m")"

    commandTest "es_attrib 'underline-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeBlinkReset() {
    RESULT="$(printf "\x1b[25m")"

    commandTest "es_attrib 'blink-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeSwapReset() {
    RESULT="$(printf "\x1b[27m")"

    commandTest "es_attrib 'swap-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeHiddenReset() {
    RESULT="$(printf "\x1b[28m")"

    commandTest "es_attrib 'hidden-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeStrikeReset() {
    RESULT="$(printf "\x1b[29m")"

    commandTest "es_attrib 'strike-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeOverlineReset() {
    RESULT="$(printf "\x1b[55m")"

    commandTest "es_attrib 'overline-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeForegroundOff() {
    RESULT="$(printf "\x1b[39m")"

    commandTest "es_attrib 'foreground-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeBackgroundOff() {
    RESULT="$(printf "\x1b[49m")"

    commandTest "es_attrib 'background-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_controlCodeUnderlineOff() {
    RESULT="$(printf "\x1b[59m")"

    commandTest "es_attrib 'underline-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_es_attrib_envVarTurnedOff() {
    setES_USE false

    commandTest "es_attrib 'clear'"

    assertCommandReturnFailure

    assertCommandOutputNull 'es_attrib function should not return output'

    setES_USE true
}


######################
# Function: es_erase #
######################

test_es_erase_controlCodeNotSpecified() {
    RESULT="$(printf "\x1b[2J")"

    commandTest "es_erase"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_controlCodeUnknown() {
    RESULT="$(printf "\x1b[2J")"

    commandTest "es_erase 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_controlCodeClear() {
    RESULT="$(printf "\x1b[2J")"

    commandTest "es_erase 'clear'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_controlCodeTop() {
    RESULT="$(printf "\x1b[1J")"

    commandTest "es_erase 'top'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_controlCodeBottom() {
    RESULT="$(printf "\x1b[0J")"

    commandTest "es_erase 'bottom'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_controlCodeCur() {
    RESULT="$(printf "\x1b[2K")"

    commandTest "es_erase 'cur'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_controlCodeSol() {
    RESULT="$(printf "\x1b[1K")"

    commandTest "es_erase 'sol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_controlCodeEol() {
    RESULT="$(printf "\x1b[0K")"

    commandTest "es_erase 'eol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_es_erase_envVarTurnedOff() {
    setES_USE false

    commandTest "es_erase 'clear'"

    assertCommandReturnFailure

    assertCommandOutputNull 'es_erase function should not return output'

    setES_USE true
}


#######################
# Function: es_cursor #
#######################

test_es_cursor_controlCodeNotSpecified() {
    RESULT="$(printf "\x1b[H")"

    commandTest "es_cursor"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeUnknown() {
    RESULT="$(printf "\x1b[H")"

    commandTest "es_cursor 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeHome() {
    RESULT="$(printf "\x1b[H")"

    commandTest "es_cursor 'home'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeRestore() {
    RESULT="$(printf "\x1b[u")"

    commandTest "es_cursor 'restore'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeSave() {
    RESULT="$(printf "\x1b[s")"

    commandTest "es_cursor 'save'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeColumnValueNotSpecified() {
    RESULT="$(printf "\x1b[0G")"

    commandTest "es_cursor 'column'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeColumn() {
    RESULT="$(printf "\x1b[4G")"

    commandTest "es_cursor 'column' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeBeginUpValueNotSpecified() {
    RESULT="$(printf "\x1b[0F")"

    commandTest "es_cursor 'begin-up'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeBeginUp() {
    RESULT="$(printf "\x1b[4F")"

    commandTest "es_cursor 'begin-up' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeBeginDownValueNotSpecified() {
    RESULT="$(printf "\x1b[0E")"

    commandTest "es_cursor 'begin-down'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeBeginDown() {
    RESULT="$(printf "\x1b[4E")"

    commandTest "es_cursor 'begin-down' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeLeftValueNotSpecified() {
    RESULT="$(printf "\x1b[0D")"

    commandTest "es_cursor 'left'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeLeft() {
    RESULT="$(printf "\x1b[4D")"

    commandTest "es_cursor 'left' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeRightValueNotSpecified() {
    RESULT="$(printf "\x1b[0C")"

    commandTest "es_cursor 'right'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeRight() {
    RESULT="$(printf "\x1b[4C")"

    commandTest "es_cursor 'right' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeDownValueNotSpecified() {
    RESULT="$(printf "\x1b[0B")"

    commandTest "es_cursor 'down'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeDown() {
    RESULT="$(printf "\x1b[4B")"

    commandTest "es_cursor 'down' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeUpValueNotSpecified() {
    RESULT="$(printf "\x1b[0A")"

    commandTest "es_cursor 'up'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeUp() {
    RESULT="$(printf "\x1b[4A")"

    commandTest "es_cursor 'up' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeAbsValueNotSpecified() {
    RESULT="$(printf "\x1b[0;0")"

    commandTest "es_cursor 'abs'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_controlCodeAbs() {
    RESULT="$(printf "\x1b[3;4")"

    commandTest "es_cursor 'abs' 3 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'es_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_es_cursor_envVarTurnedOff() {
    setES_USE false

    commandTest "es_cursor 'home'"

    assertCommandReturnFailure

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
    RESULT="$(tput setaf 1)"

    commandTest "nc 'setaf' '1'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc 'setaf' '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'nc function should not return output'

    setNC_USE true
}

test_nc_cmdTputEmpty() {
    CMD_TPUT=""

    assertNull 'CMD_TPUT environment variable not empty' "${CMD_TPUT}"

    commandTest "nc 'setaf' '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'nc function should not return output'

    CMD_TPUT="$(command -v tput)"

    assertNotNull 'CMD_TPUT environment variable empty' "${CMD_TPUT}"
}


######################
# Function: nc_color #
######################

test_nc_color_roleNotSpecified() {
    RESULT="$(tput setaf 1)"

    commandTest "nc_color '1'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_roleEmpty() {
    RESULT="$(tput setaf 1)"

    commandTest "nc_color '1' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_roleLowerCaseF() {
    RESULT="$(tput setaf 1)"

    commandTest "nc_color '1' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_roleUpperCaseF() {
    RESULT="$(tput setaf 1)"

    commandTest "nc_color '1' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_roleForeground() {
    RESULT="$(tput setaf 1)"

    commandTest "nc_color '1' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_roleLowerCaseB() {
    RESULT="$(tput setab 1)"

    commandTest "nc_color '1' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_roleUpperCaseF() {
    RESULT="$(tput setab 1)"

    commandTest "nc_color '1' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_roleBackground() {
    RESULT="$(tput setab 1)"

    commandTest "nc_color '1' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_color function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_color_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_color '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'nc_color function should not return output'

    setNC_USE true
}


#######################
# Function: nc_attrib #
#######################

test_nc_attrib_controlCodeNotSpecified() {
    RESULT="$(tput sgr0)"

    commandTest "nc_attrib"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeUnknown() {
    RESULT="$(tput sgr0)"

    commandTest "nc_attrib 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeReset() {
    RESULT="$(tput sgr0)"

    commandTest "nc_attrib 'reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeBold() {
    RESULT="$(tput bold)"

    commandTest "nc_attrib 'bold'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeDim() {
    RESULT="$(tput dim)"

    commandTest "nc_attrib 'dim'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeItalic() {
    RESULT="$(tput sitm)"

    commandTest "nc_attrib 'italic'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeUnderlineOff() {
    RESULT="$(tput rmul)"

    commandTest "nc_attrib 'underline-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeUnderline() {
    RESULT="$(tput smul)"

    commandTest "nc_attrib 'underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeBlink() {
    RESULT="$(tput blink)"

    commandTest "nc_attrib 'blink'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeReverse() {
    RESULT="$(tput rev)"

    commandTest "nc_attrib 'reverse'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeInvisible() {
    RESULT="$(tput invis)"

    commandTest "nc_attrib 'invisible'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeStandoutOff() {
    RESULT="$(tput rmso)"

    commandTest "nc_attrib 'standout-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_controlCodeStandout() {
    RESULT="$(tput smso)"

    commandTest "nc_attrib 'standout'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_attrib function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_attrib_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_attrib"

    assertCommandReturnFailure

    assertCommandOutputNull 'nc_attrib function should not return output'

    setNC_USE true
}


######################
# Function: nc_erase #
######################

test_nc_erase_controlCodeNotSpecified() {
    RESULT="$(tput clear)"

    commandTest "nc_erase"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeUnknown() {
    RESULT="$(tput clear)"

    commandTest "nc_erase 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeClear() {
    RESULT="$(tput clear)"

    commandTest "nc_erase 'clear'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertLinesNoValueSpecified() {
    RESULT="$(tput il 0)"

    commandTest "nc_erase 'il'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertLines() {
    RESULT="$(tput il 4)"

    commandTest "nc_erase 'il' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertCharactersNoValueSpecified() {
    RESULT="$(tput ich 0)"

    commandTest "nc_erase 'ic'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeInsertCharacters() {
    RESULT="$(tput ich 4)"

    commandTest "nc_erase 'ic' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeCharactersNoValueSpecified() {
    RESULT="$(tput ech 0)"

    commandTest "nc_erase 'en'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeCharacters() {
    RESULT="$(tput ech 4)"

    commandTest "nc_erase 'en' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeEndOfScreen() {
    RESULT="$(tput ed)"

    commandTest "nc_erase 'eos'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeEndOfLine() {
    RESULT="$(tput el)"

    commandTest "nc_erase 'eol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_controlCodeStartOfLine() {
    RESULT="$(tput el1)"

    commandTest "nc_erase 'sol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_erase function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_erase_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_erase"

    assertCommandReturnFailure

    assertCommandOutputNull 'nc_erase function should not return output'

    setNC_USE true
}


#######################
# Function: nc_cursor #
#######################

test_nc_cursor_controlCodeNotSpecified() {
    RESULT="$(tput home)"

    commandTest "nc_cursor"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeUnknown() {
    RESULT="$(tput home)"

    commandTest "nc_cursor 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeHome() {
    RESULT="$(tput home)"

    commandTest "nc_cursor 'home'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeAbsolutePositionNoValueSpecified() {
    RESULT="$(tput cup '0;0')"

    commandTest "nc_cursor 'abs'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeAbsolutePosition() {
    RESULT="$(tput cup '3;4')"

    commandTest "nc_cursor 'abs' 3 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeRightNoValueSpecified() {
    RESULT="$(tput cuf 0)"

    commandTest "nc_cursor 'right'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeRight() {
    RESULT="$(tput cuf 4)"

    commandTest "nc_cursor 'right' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeLeftNoValueSpecified() {
    RESULT="$(tput cub 0)"

    commandTest "nc_cursor 'left'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeLeft() {
    RESULT="$(tput cub 4)"

    commandTest "nc_cursor 'left' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeDown() {
    RESULT="$(tput cud1)"

    commandTest "nc_cursor 'down'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeUp() {
    RESULT="$(tput cuu1)"

    commandTest "nc_cursor 'up'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeInvisibleOff() {
    RESULT="$(tput cvvis)"

    commandTest "nc_cursor 'invisible-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeInvisible() {
    RESULT="$(tput civis)"

    commandTest "nc_cursor 'invisible'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeRestore() {
    RESULT="$(tput rc)"

    commandTest "nc_cursor 'restore'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_controlCodeSave() {
    RESULT="$(tput sc)"

    commandTest "nc_cursor 'save'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'nc_cursor function not returning correct control sequence' \
        "${RESULT}"
}

test_nc_cursor_envVarTurnedOff() {
    setNC_USE false

    commandTest "nc_cursor"

    assertCommandReturnFailure

    assertCommandOutputNull 'nc_cursor function should not return output'

    setNC_USE true
}
