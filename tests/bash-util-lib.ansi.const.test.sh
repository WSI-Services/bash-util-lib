#!/usr/bin/env bash
# file: bash-util-lib.ansi.test.sh

# shellcheck disable=SC2154 # var is referenced but not assigned.
# shellcheck disable=SC2317 # Command appears to be unreachable. Check usage (or ignore if invoked indirectly).


TESTS_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="$(readlink -f "${TESTS_DIR}/../src")"

# shellcheck source=../src/bash-util-lib.ansi.const.sh
. "${SOURCE_DIR}/bash-util-lib.ansi.const.sh"


#############
# Constants #
#############

function test::ansi::constant::ANSI_ESC() {
    assertEquals "${ANSI_ESC}" "\x1B"
}

function test::ansi::constant::ANSI_CSI() {
    assertEquals "${ANSI_CSI}" "\x1B["
}

function test::ansi::constant::ANSI_DCS() {
    assertEquals "${ANSI_DCS}" "\x1BP"
}

function test::ansi::constant::ANSI_OSC() {
    assertEquals "${ANSI_OSC}" "\x1B]"
}

function test::ansi::constant::ANSI_RESET() {
    assertEquals "${ANSI_RESET}" "\x1B[0m"
}

function test::ansi::constant::ANSI_BOLD() {
    assertEquals "${ANSI_BOLD}" "\x1B[1m"
}

function test::ansi::constant::ANSI_FAINT() {
    assertEquals "${ANSI_FAINT}" "\x1B[2m"
}

function test::ansi::constant::ANSI_ITALIC() {
    assertEquals "${ANSI_ITALIC}" "\x1B[3m"
}

function test::ansi::constant::ANSI_UNDERLINE() {
    assertEquals "${ANSI_UNDERLINE}" "\x1B[4m"
}

function test::ansi::constant::ANSI_BLINK() {
    assertEquals "${ANSI_BLINK}" "\x1B[5m"
}

function test::ansi::constant::ANSI_BLINK_FAST() {
    assertEquals "${ANSI_BLINK_FAST}" "\x1B[6m"
}

function test::ansi::constant::ANSI_SWAP() {
    assertEquals "${ANSI_SWAP}" "\x1B[7m"
}

function test::ansi::constant::ANSI_HIDDEN() {
    assertEquals "${ANSI_HIDDEN}" "\x1B[8m"
}

function test::ansi::constant::ANSI_STRIKE() {
    assertEquals "${ANSI_STRIKE}" "\x1B[9m"
}

function test::ansi::constant::ANSI_OVERLINE() {
    assertEquals "${ANSI_OVERLINE}" "\x1B[53m"
}

function test::ansi::constant::ANSI_BOLD_RESET() {
    assertEquals "${ANSI_BOLD_RESET}" "\x1B[22m"
}

function test::ansi::constant::ANSI_FAINT_RESET() {
    assertEquals "${ANSI_FAINT_RESET}" "\x1B[22m"
}

function test::ansi::constant::ANSI_ITALIC_RESET() {
    assertEquals "${ANSI_ITALIC_RESET}" "\x1B[23m"
}

function test::ansi::constant::ANSI_UNDERLINE_RESET() {
    assertEquals "${ANSI_UNDERLINE_RESET}" "\x1B[24m"
}

function test::ansi::constant::ANSI_BLINK_RESET() {
    assertEquals "${ANSI_BLINK_RESET}" "\x1B[25m"
}

function test::ansi::constant::ANSI_SWAP_RESET() {
    assertEquals "${ANSI_SWAP_RESET}" "\x1B[27m"
}

function test::ansi::constant::ANSI_HIDDEN_RESET() {
    assertEquals "${ANSI_HIDDEN_RESET}" "\x1B[28m"
}

function test::ansi::constant::ANSI_STRIKE_RESET() {
    assertEquals "${ANSI_STRIKE_RESET}" "\x1B[29m"
}

function test::ansi::constant::ANSI_OVERLINE_RESET() {
    assertEquals "${ANSI_OVERLINE_RESET}" "\x1B[55m"
}

function test::ansi::constant::ANSI_BLACK() {
    assertEquals "${ANSI_BLACK}" "\x1B[30m"
}

function test::ansi::constant::ANSI_RED() {
    assertEquals "${ANSI_RED}" "\x1B[31m"
}

function test::ansi::constant::ANSI_GREEN() {
    assertEquals "${ANSI_GREEN}" "\x1B[32m"
}

function test::ansi::constant::ANSI_YELLOW() {
    assertEquals "${ANSI_YELLOW}" "\x1B[33m"
}

function test::ansi::constant::ANSI_BLUE() {
    assertEquals "${ANSI_BLUE}" "\x1B[34m"
}

function test::ansi::constant::ANSI_MAGENTA() {
    assertEquals "${ANSI_MAGENTA}" "\x1B[35m"
}

function test::ansi::constant::ANSI_CYAN() {
    assertEquals "${ANSI_CYAN}" "\x1B[36m"
}

function test::ansi::constant::ANSI_WHITE() {
    assertEquals "${ANSI_WHITE}" "\x1B[37m"
}

function test::ansi::constant::ANSI_DEFAULT() {
    assertEquals "${ANSI_DEFAULT}" "\x1B[39m"
}

function test::ansi::constant::ANSI_BLACK_BG() {
    assertEquals "${ANSI_BLACK_BG}" "\x1B[40m"
}

function test::ansi::constant::ANSI_RED_BG() {
    assertEquals "${ANSI_RED_BG}" "\x1B[41m"
}

function test::ansi::constant::ANSI_GREEN_BG() {
    assertEquals "${ANSI_GREEN_BG}" "\x1B[42m"
}

function test::ansi::constant::ANSI_YELLOW_BG() {
    assertEquals "${ANSI_YELLOW_BG}" "\x1B[43m"
}

function test::ansi::constant::ANSI_BLUE_BG() {
    assertEquals "${ANSI_BLUE_BG}" "\x1B[44m"
}

function test::ansi::constant::ANSI_MAGENTA_BG() {
    assertEquals "${ANSI_MAGENTA_BG}" "\x1B[45m"
}

function test::ansi::constant::ANSI_CYAN_BG() {
    assertEquals "${ANSI_CYAN_BG}" "\x1B[46m"
}

function test::ansi::constant::ANSI_WHITE_BG() {
    assertEquals "${ANSI_WHITE_BG}" "\x1B[47m"
}

function test::ansi::constant::ANSI_DEFAULT_BG() {
    assertEquals "${ANSI_DEFAULT_BG}" "\x1B[49m"
}

function test::ansi::constant::ANSI_BRIGHT_BLACK() {
    assertEquals "${ANSI_BRIGHT_BLACK}" "\x1B[90m"
}

function test::ansi::constant::ANSI_BRIGHT_RED() {
    assertEquals "${ANSI_BRIGHT_RED}" "\x1B[91m"
}

function test::ansi::constant::ANSI_BRIGHT_GREEN() {
    assertEquals "${ANSI_BRIGHT_GREEN}" "\x1B[92m"
}

function test::ansi::constant::ANSI_BRIGHT_YELLOW() {
    assertEquals "${ANSI_BRIGHT_YELLOW}" "\x1B[93m"
}

function test::ansi::constant::ANSI_BRIGHT_BLUE() {
    assertEquals "${ANSI_BRIGHT_BLUE}" "\x1B[94m"
}

function test::ansi::constant::ANSI_BRIGHT_MAGENTA() {
    assertEquals "${ANSI_BRIGHT_MAGENTA}" "\x1B[95m"
}

function test::ansi::constant::ANSI_BRIGHT_CYAN() {
    assertEquals "${ANSI_BRIGHT_CYAN}" "\x1B[96m"
}

function test::ansi::constant::ANSI_BRIGHT_WHITE() {
    assertEquals "${ANSI_BRIGHT_WHITE}" "\x1B[97m"
}

function test::ansi::constant::ANSI_BRIGHT_BLACK_BG() {
    assertEquals "${ANSI_BRIGHT_BLACK_BG}" "\x1B[100m"
}

function test::ansi::constant::ANSI_BRIGHT_RED_BG() {
    assertEquals "${ANSI_BRIGHT_RED_BG}" "\x1B[101m"
}

function test::ansi::constant::ANSI_BRIGHT_GREEN_BG() {
    assertEquals "${ANSI_BRIGHT_GREEN_BG}" "\x1B[102m"
}

function test::ansi::constant::ANSI_BRIGHT_YELLOW_BG() {
    assertEquals "${ANSI_BRIGHT_YELLOW_BG}" "\x1B[103m"
}

function test::ansi::constant::ANSI_BRIGHT_BLUE_BG() {
    assertEquals "${ANSI_BRIGHT_BLUE_BG}" "\x1B[104m"
}

function test::ansi::constant::ANSI_BRIGHT_MAGENTA_BG() {
    assertEquals "${ANSI_BRIGHT_MAGENTA_BG}" "\x1B[105m"
}

function test::ansi::constant::ANSI_BRIGHT_CYAN_BG() {
    assertEquals "${ANSI_BRIGHT_CYAN_BG}" "\x1B[106m"
}

function test::ansi::constant::ANSI_BRIGHT_WHITE_BG() {
    assertEquals "${ANSI_BRIGHT_WHITE_BG}" "\x1B[107m"
}
