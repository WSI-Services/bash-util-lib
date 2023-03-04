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

function helper::set::ES_USE() {
    local SET_VALUE="$1"

    case "${SET_VALUE}" in
         true) ES_USE=true ;;
        false) ES_USE=false ;;
            *) fail "ES_USE failed to be set: provide 'true' or 'false'"
    esac
}

function helper::set:NC_USE() {
    local SET_VALUE="$1"

    case "${SET_VALUE}" in
         true) NC_USE=true ;;
        false) NC_USE=false ;;
            *) fail "NC_USE failed to be set: provide 'true' or 'false'"
    esac
}


######################
# Function: ansi::es #
######################

function test::ansi::es::withEnvVarTurnedOnByDefault() {
    assertTrue 'ES_USE environment variable not set to true by default' "${ES_USE}"
}

function test::ansi::es::withControlCode() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "ansi::es '38;5;1m'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::withEnvVarTurnedOff() {
    helper::set::ES_USE false

    commandTest "ansi::es '38;5;1m'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::es function should not return output'

    helper::set::ES_USE true
}


#############################
# Function: ansi::es::color #
#############################

function test::ansi::es::color::withRoleNotSpecified() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "ansi::es::color '1'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleEmpty() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "ansi::es::color '1' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleLowerCaseF() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "ansi::es::color '1' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleUpperCaseF() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "ansi::es::color '1' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleForeground() {
    RESULT="$(printf "\x1b[38;5;1m")"

    commandTest "ansi::es::color '1' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleLowerCaseB() {
    RESULT="$(printf "\x1b[48;5;1m")"

    commandTest "ansi::es::color '1' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleUpperCaseB() {
    RESULT="$(printf "\x1b[48;5;1m")"

    commandTest "ansi::es::color '1' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleBackground() {
    RESULT="$(printf "\x1b[48;5;1m")"

    commandTest "ansi::es::color '1' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleLowerCaseU() {
    RESULT="$(printf "\x1b[58;5;1m")"

    commandTest "ansi::es::color '1' 'u'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleUpperCaseU() {
    RESULT="$(printf "\x1b[58;5;1m")"

    commandTest "ansi::es::color '1' 'U'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withRoleUnderline() {
    RESULT="$(printf "\x1b[58;5;1m")"

    commandTest "ansi::es::color '1' 'Underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::color::withEnvVarTurnedOff() {
    helper::set::ES_USE false

    commandTest "ansi::es::color '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::es::color function should not return output'

    helper::set::ES_USE true
}


################################
# Function: ansi::es::colorRgb #
################################

function test::ansi::es::colorRgb::withRoleNotSpecified() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleEmpty() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleLowerCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleUpperCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleForeground() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleLowerCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleUpperCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleBackground() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleLowerCaseU() {
    RESULT="$(printf "\x1b[58;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'u'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleUpperCaseU() {
    RESULT="$(printf "\x1b[58;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'U'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withRoleUnderline() {
    RESULT="$(printf "\x1b[58;2;255;127;127m")"

    commandTest "ansi::es::colorRgb '255' '127' '127' 'Underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorRgb function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorRgb::withEnvVarTurnedOff() {
    helper::set::ES_USE false

    commandTest "ansi::es::colorRgb '255' '127' '127'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::es::colorRgb function should not return output'

    helper::set::ES_USE true
}


################################
# Function: ansi::es::colorHex #
################################

function test::ansi::es::colorHex::withRoleNotSpecified() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withRoleEmpty() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withRoleLowerCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withRoleUpperCaseF() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withRoleForeground() {
    RESULT="$(printf "\x1b[38;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withRoleLowerCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withRoleUpperCaseB() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withRoleBackground() {
    RESULT="$(printf "\x1b[48;2;255;127;127m")"

    commandTest "ansi::es::colorHex 'ff7f7f' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::colorHex function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::colorHex::withEnvVarTurnedOff() {
    helper::set::ES_USE false

    commandTest "ansi::es::colorHex 'ff7f7f'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::es::colorHex function should not return output'

    helper::set::ES_USE true
}


##############################
# Function: ansi::es::attrib #
##############################

function test::ansi::es::attrib::withControlCodeNotSpecified() {
    RESULT="$(printf "\x1b[0m")"

    commandTest "ansi::es::attrib"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeUnknown() {
    RESULT="$(printf "\x1b[0m")"

    commandTest "ansi::es::attrib 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeReset() {
    RESULT="$(printf "\x1b[0m")"

    commandTest "ansi::es::attrib 'reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeBold() {
    RESULT="$(printf "\x1b[1m")"

    commandTest "ansi::es::attrib 'bold'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeFaint() {
    RESULT="$(printf "\x1b[2m")"

    commandTest "ansi::es::attrib 'faint'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeItalic() {
    RESULT="$(printf "\x1b[3m")"

    commandTest "ansi::es::attrib 'italic'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeUnderline() {
    RESULT="$(printf "\x1b[4m")"

    commandTest "ansi::es::attrib 'underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeBlink() {
    RESULT="$(printf "\x1b[5m")"

    commandTest "ansi::es::attrib 'blink'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeFastBlink() {
    RESULT="$(printf "\x1b[6m")"

    commandTest "ansi::es::attrib 'fast-blink'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeSwap() {
    RESULT="$(printf "\x1b[7m")"

    commandTest "ansi::es::attrib 'swap'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeHidden() {
    RESULT="$(printf "\x1b[8m")"

    commandTest "ansi::es::attrib 'hidden'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeStrike() {
    RESULT="$(printf "\x1b[9m")"

    commandTest "ansi::es::attrib 'strike'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeOverline() {
    RESULT="$(printf "\x1b[53m")"

    commandTest "ansi::es::attrib 'overline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeBoldReset() {
    RESULT="$(printf "\x1b[22m")"

    commandTest "ansi::es::attrib 'bold-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeFaintReset() {
    RESULT="$(printf "\x1b[22m")"

    commandTest "ansi::es::attrib 'faint-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeItalicReset() {
    RESULT="$(printf "\x1b[23m")"

    commandTest "ansi::es::attrib 'italic-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeUnderlineReset() {
    RESULT="$(printf "\x1b[24m")"

    commandTest "ansi::es::attrib 'underline-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeBlinkReset() {
    RESULT="$(printf "\x1b[25m")"

    commandTest "ansi::es::attrib 'blink-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeSwapReset() {
    RESULT="$(printf "\x1b[27m")"

    commandTest "ansi::es::attrib 'swap-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeHiddenReset() {
    RESULT="$(printf "\x1b[28m")"

    commandTest "ansi::es::attrib 'hidden-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeStrikeReset() {
    RESULT="$(printf "\x1b[29m")"

    commandTest "ansi::es::attrib 'strike-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeOverlineReset() {
    RESULT="$(printf "\x1b[55m")"

    commandTest "ansi::es::attrib 'overline-reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeForegroundOff() {
    RESULT="$(printf "\x1b[39m")"

    commandTest "ansi::es::attrib 'foreground-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeBackgroundOff() {
    RESULT="$(printf "\x1b[49m")"

    commandTest "ansi::es::attrib 'background-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withControlCodeUnderlineOff() {
    RESULT="$(printf "\x1b[59m")"

    commandTest "ansi::es::attrib 'underline-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::attrib::withEnvVarTurnedOff() {
    helper::set::ES_USE false

    commandTest "ansi::es::attrib 'clear'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::es::attrib function should not return output'

    helper::set::ES_USE true
}


#############################
# Function: ansi::es::erase #
#############################

function test::ansi::es::erase::withControlCodeNotSpecified() {
    RESULT="$(printf "\x1b[2J")"

    commandTest "ansi::es::erase"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withControlCodeUnknown() {
    RESULT="$(printf "\x1b[2J")"

    commandTest "ansi::es::erase 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withControlCodeClear() {
    RESULT="$(printf "\x1b[2J")"

    commandTest "ansi::es::erase 'clear'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withControlCodeTop() {
    RESULT="$(printf "\x1b[1J")"

    commandTest "ansi::es::erase 'top'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withControlCodeBottom() {
    RESULT="$(printf "\x1b[0J")"

    commandTest "ansi::es::erase 'bottom'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withControlCodeCur() {
    RESULT="$(printf "\x1b[2K")"

    commandTest "ansi::es::erase 'cur'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withControlCodeSol() {
    RESULT="$(printf "\x1b[1K")"

    commandTest "ansi::es::erase 'sol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withControlCodeEol() {
    RESULT="$(printf "\x1b[0K")"

    commandTest "ansi::es::erase 'eol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::erase::withCnvVarTurnedOff() {
    helper::set::ES_USE false

    commandTest "ansi::es::erase 'clear'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::es::erase function should not return output'

    helper::set::ES_USE true
}


##############################
# Function: ansi::es::cursor #
##############################

function test::ansi::es::cursor::withControlCodeNotSpecified() {
    RESULT="$(printf "\x1b[H")"

    commandTest "ansi::es::cursor"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeUnknown() {
    RESULT="$(printf "\x1b[H")"

    commandTest "ansi::es::cursor 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeHome() {
    RESULT="$(printf "\x1b[H")"

    commandTest "ansi::es::cursor 'home'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeRestore() {
    RESULT="$(printf "\x1b[u")"

    commandTest "ansi::es::cursor 'restore'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeSave() {
    RESULT="$(printf "\x1b[s")"

    commandTest "ansi::es::cursor 'save'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeColumnValueNotSpecified() {
    RESULT="$(printf "\x1b[0G")"

    commandTest "ansi::es::cursor 'column'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeColumn() {
    RESULT="$(printf "\x1b[4G")"

    commandTest "ansi::es::cursor 'column' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeBeginUpValueNotSpecified() {
    RESULT="$(printf "\x1b[0F")"

    commandTest "ansi::es::cursor 'begin-up'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeBeginUp() {
    RESULT="$(printf "\x1b[4F")"

    commandTest "ansi::es::cursor 'begin-up' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeBeginDownValueNotSpecified() {
    RESULT="$(printf "\x1b[0E")"

    commandTest "ansi::es::cursor 'begin-down'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeBeginDown() {
    RESULT="$(printf "\x1b[4E")"

    commandTest "ansi::es::cursor 'begin-down' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeLeftValueNotSpecified() {
    RESULT="$(printf "\x1b[0D")"

    commandTest "ansi::es::cursor 'left'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeLeft() {
    RESULT="$(printf "\x1b[4D")"

    commandTest "ansi::es::cursor 'left' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeRightValueNotSpecified() {
    RESULT="$(printf "\x1b[0C")"

    commandTest "ansi::es::cursor 'right'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeRight() {
    RESULT="$(printf "\x1b[4C")"

    commandTest "ansi::es::cursor 'right' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeDownValueNotSpecified() {
    RESULT="$(printf "\x1b[0B")"

    commandTest "ansi::es::cursor 'down'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeDown() {
    RESULT="$(printf "\x1b[4B")"

    commandTest "ansi::es::cursor 'down' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeUpValueNotSpecified() {
    RESULT="$(printf "\x1b[0A")"

    commandTest "ansi::es::cursor 'up'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeUp() {
    RESULT="$(printf "\x1b[4A")"

    commandTest "ansi::es::cursor 'up' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeAbsValueNotSpecified() {
    RESULT="$(printf "\x1b[0;0")"

    commandTest "ansi::es::cursor 'abs'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withControlCodeAbs() {
    RESULT="$(printf "\x1b[3;4")"

    commandTest "ansi::es::cursor 'abs' 3 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::es::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::es::cursor::withEnvVarTurnedOff() {
    helper::set::ES_USE false

    commandTest "ansi::es::cursor 'home'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::es::cursor function should not return output'

    helper::set::ES_USE true
}


######################
# Function: ansi::nc #
######################

function test::ansi::nc::withEnvVarTurnedOnByDefault() {
    assertTrue 'NC_USE environment variable not set to true by default' "${NC_USE}"
}

function test::ansi::nc::withControlCode() {
    RESULT="$(tput setaf 1)"

    commandTest "ansi::nc 'setaf' '1'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::withEnvVarTurnedOff() {
    helper::set:NC_USE false

    commandTest "ansi::nc 'setaf' '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::nc function should not return output'

    helper::set:NC_USE true
}

function test::ansi::nc::withCmdTputEmpty() {
    CMD_TPUT=""

    assertNull 'CMD_TPUT environment variable not empty' "${CMD_TPUT}"

    commandTest "ansi::nc 'setaf' '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::nc function should not return output'

    CMD_TPUT="$(command -v tput)"

    assertNotNull 'CMD_TPUT environment variable empty' "${CMD_TPUT}"
}


#############################
# Function: ansi::nc::color #
#############################

function test::ansi::nc::color::withRoleNotSpecified() {
    RESULT="$(tput setaf 1)"

    commandTest "ansi::nc::color '1'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withRoleEmpty() {
    RESULT="$(tput setaf 1)"

    commandTest "ansi::nc::color '1' ''"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withRoleLowerCaseF() {
    RESULT="$(tput setaf 1)"

    commandTest "ansi::nc::color '1' 'f'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withRoleUpperCaseF() {
    RESULT="$(tput setaf 1)"

    commandTest "ansi::nc::color '1' 'F'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withRoleForeground() {
    RESULT="$(tput setaf 1)"

    commandTest "ansi::nc::color '1' 'Foreground'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withRoleLowerCaseB() {
    RESULT="$(tput setab 1)"

    commandTest "ansi::nc::color '1' 'b'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withRoleUpperCaseB() {
    RESULT="$(tput setab 1)"

    commandTest "ansi::nc::color '1' 'B'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withRoleBackground() {
    RESULT="$(tput setab 1)"

    commandTest "ansi::nc::color '1' 'Background'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::color function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::color::withEnvVarTurnedOff() {
    helper::set:NC_USE false

    commandTest "ansi::nc::color '1'"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::nc::color function should not return output'

    helper::set:NC_USE true
}


##############################
# Function: ansi::nc::attrib #
##############################

function test::ansi::nc::attrib::withControlCodeNotSpecified() {
    RESULT="$(tput sgr0)"

    commandTest "ansi::nc::attrib"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeUnknown() {
    RESULT="$(tput sgr0)"

    commandTest "ansi::nc::attrib 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeReset() {
    RESULT="$(tput sgr0)"

    commandTest "ansi::nc::attrib 'reset'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeBold() {
    RESULT="$(tput bold)"

    commandTest "ansi::nc::attrib 'bold'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeDim() {
    RESULT="$(tput dim)"

    commandTest "ansi::nc::attrib 'dim'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeItalic() {
    RESULT="$(tput sitm)"

    commandTest "ansi::nc::attrib 'italic'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeUnderlineOff() {
    RESULT="$(tput rmul)"

    commandTest "ansi::nc::attrib 'underline-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeUnderline() {
    RESULT="$(tput smul)"

    commandTest "ansi::nc::attrib 'underline'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeBlink() {
    RESULT="$(tput blink)"

    commandTest "ansi::nc::attrib 'blink'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeReverse() {
    RESULT="$(tput rev)"

    commandTest "ansi::nc::attrib 'reverse'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeInvisible() {
    RESULT="$(tput invis)"

    commandTest "ansi::nc::attrib 'invisible'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeStandoutOff() {
    RESULT="$(tput rmso)"

    commandTest "ansi::nc::attrib 'standout-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withControlCodeStandout() {
    RESULT="$(tput smso)"

    commandTest "ansi::nc::attrib 'standout'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::attrib function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::attrib::withEnvVarTurnedOff() {
    helper::set:NC_USE false

    commandTest "ansi::nc::attrib"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::nc::attrib function should not return output'

    helper::set:NC_USE true
}


#############################
# Function: ansi::nc::erase #
#############################

function test::ansi::nc::erase::withControlCodeNotSpecified() {
    RESULT="$(tput clear)"

    commandTest "ansi::nc::erase"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeUnknown() {
    RESULT="$(tput clear)"

    commandTest "ansi::nc::erase 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeClear() {
    RESULT="$(tput clear)"

    commandTest "ansi::nc::erase 'clear'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeInsertLinesNoValueSpecified() {
    RESULT="$(tput il 0)"

    commandTest "ansi::nc::erase 'il'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeInsertLines() {
    RESULT="$(tput il 4)"

    commandTest "ansi::nc::erase 'il' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeInsertCharactersNoValueSpecified() {
    RESULT="$(tput ich 0)"

    commandTest "ansi::nc::erase 'ic'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeInsertCharacters() {
    RESULT="$(tput ich 4)"

    commandTest "ansi::nc::erase 'ic' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeCharactersNoValueSpecified() {
    RESULT="$(tput ech 0)"

    commandTest "ansi::nc::erase 'en'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeCharacters() {
    RESULT="$(tput ech 4)"

    commandTest "ansi::nc::erase 'en' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeEndOfScreen() {
    RESULT="$(tput ed)"

    commandTest "ansi::nc::erase 'eos'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeEndOfLine() {
    RESULT="$(tput el)"

    commandTest "ansi::nc::erase 'eol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withControlCodeStartOfLine() {
    RESULT="$(tput el1)"

    commandTest "ansi::nc::erase 'sol'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::erase function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::erase::withEnvVarTurnedOff() {
    helper::set:NC_USE false

    commandTest "ansi::nc::erase"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::nc::erase function should not return output'

    helper::set:NC_USE true
}


##############################
# Function: ansi::nc::cursor #
##############################

function test::ansi::nc::cursor::withControlCodeNotSpecified() {
    RESULT="$(tput home)"

    commandTest "ansi::nc::cursor"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeUnknown() {
    RESULT="$(tput home)"

    commandTest "ansi::nc::cursor 'anything'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeHome() {
    RESULT="$(tput home)"

    commandTest "ansi::nc::cursor 'home'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeAbsolutePositionNoValueSpecified() {
    RESULT="$(tput cup '0;0')"

    commandTest "ansi::nc::cursor 'abs'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeAbsolutePosition() {
    RESULT="$(tput cup '3;4')"

    commandTest "ansi::nc::cursor 'abs' 3 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeRightNoValueSpecified() {
    RESULT="$(tput cuf 0)"

    commandTest "ansi::nc::cursor 'right'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeRight() {
    RESULT="$(tput cuf 4)"

    commandTest "ansi::nc::cursor 'right' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeLeftNoValueSpecified() {
    RESULT="$(tput cub 0)"

    commandTest "ansi::nc::cursor 'left'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeLeft() {
    RESULT="$(tput cub 4)"

    commandTest "ansi::nc::cursor 'left' 4"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeDown() {
    RESULT="$(tput cud1)"

    commandTest "ansi::nc::cursor 'down'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeUp() {
    RESULT="$(tput cuu1)"

    commandTest "ansi::nc::cursor 'up'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeInvisibleOff() {
    RESULT="$(tput cvvis)"

    commandTest "ansi::nc::cursor 'invisible-off'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeInvisible() {
    RESULT="$(tput civis)"

    commandTest "ansi::nc::cursor 'invisible'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeRestore() {
    RESULT="$(tput rc)"

    commandTest "ansi::nc::cursor 'restore'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withControlCodeSave() {
    RESULT="$(tput sc)"

    commandTest "ansi::nc::cursor 'save'"

    assertCommandReturnSuccess

    assertCommandOutputEquals 'ansi::nc::cursor function not returning correct control sequence' \
        "${RESULT}"
}

function test::ansi::nc::cursor::withEnvVarTurnedOff() {
    helper::set:NC_USE false

    commandTest "ansi::nc::cursor"

    assertCommandReturnFailure

    assertCommandOutputNull 'ansi::nc::cursor function should not return output'

    helper::set:NC_USE true
}
