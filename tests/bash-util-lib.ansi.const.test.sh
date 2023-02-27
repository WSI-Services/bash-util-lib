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


test_constant_ansi_esc() {
    assertEquals "${ANSI_ESC}" "\x1B"
}

test_constant_ansi_csi() {
    assertEquals "${ANSI_CSI}" "\x1B["
}

test_constant_ansi_dcs() {
    assertEquals "${ANSI_DCS}" "\x1BP"
}

test_constant_ansi_osc() {
    assertEquals "${ANSI_OSC}" "\x1B]"
}

test_constant_ansi_reset() {
    assertEquals "${ANSI_RESET}" "\x1B[0m"
}

test_constant_ansi_bold() {
    assertEquals "${ANSI_BOLD}" "\x1B[1m"
}

test_constant_ansi_faint() {
    assertEquals "${ANSI_FAINT}" "\x1B[2m"
}

test_constant_ansi_italic() {
    assertEquals "${ANSI_ITALIC}" "\x1B[3m"
}

test_constant_ansi_underline() {
    assertEquals "${ANSI_UNDERLINE}" "\x1B[4m"
}

test_constant_ansi_blink() {
    assertEquals "${ANSI_BLINK}" "\x1B[5m"
}

test_constant_ansi_blink_fast() {
    assertEquals "${ANSI_BLINK_FAST}" "\x1B[6m"
}

test_constant_ansi_swap() {
    assertEquals "${ANSI_SWAP}" "\x1B[7m"
}

test_constant_ansi_hidden() {
    assertEquals "${ANSI_HIDDEN}" "\x1B[8m"
}

test_constant_ansi_strike() {
    assertEquals "${ANSI_STRIKE}" "\x1B[9m"
}

test_constant_ansi_overline() {
    assertEquals "${ANSI_OVERLINE}" "\x1B[53m"
}

test_constant_ansi_bold_reset() {
    assertEquals "${ANSI_BOLD_RESET}" "\x1B[22m"
}

test_constant_ansi_faint_reset() {
    assertEquals "${ANSI_FAINT_RESET}" "\x1B[22m"
}

test_constant_ansi_italic_reset() {
    assertEquals "${ANSI_ITALIC_RESET}" "\x1B[23m"
}

test_constant_ansi_underline_reset() {
    assertEquals "${ANSI_UNDERLINE_RESET}" "\x1B[24m"
}

test_constant_ansi_blink_reset() {
    assertEquals "${ANSI_BLINK_RESET}" "\x1B[25m"
}

test_constant_ansi_swap_reset() {
    assertEquals "${ANSI_SWAP_RESET}" "\x1B[27m"
}

test_constant_ansi_hidden_reset() {
    assertEquals "${ANSI_HIDDEN_RESET}" "\x1B[28m"
}

test_constant_ansi_strike_reset() {
    assertEquals "${ANSI_STRIKE_RESET}" "\x1B[29m"
}

test_constant_ansi_overline_reset() {
    assertEquals "${ANSI_OVERLINE_RESET}" "\x1B[55m"
}

test_constant_ansi_black() {
    assertEquals "${ANSI_BLACK}" "\x1B[30m"
}

test_constant_ansi_red() {
    assertEquals "${ANSI_RED}" "\x1B[31m"
}

test_constant_ansi_green() {
    assertEquals "${ANSI_GREEN}" "\x1B[32m"
}

test_constant_ansi_yellow() {
    assertEquals "${ANSI_YELLOW}" "\x1B[33m"
}

test_constant_ansi_blue() {
    assertEquals "${ANSI_BLUE}" "\x1B[34m"
}

test_constant_ansi_magenta() {
    assertEquals "${ANSI_MAGENTA}" "\x1B[35m"
}

test_constant_ansi_cyan() {
    assertEquals "${ANSI_CYAN}" "\x1B[36m"
}

test_constant_ansi_white() {
    assertEquals "${ANSI_WHITE}" "\x1B[37m"
}

test_constant_ansi_default() {
    assertEquals "${ANSI_DEFAULT}" "\x1B[39m"
}

test_constant_ansi_black_bg() {
    assertEquals "${ANSI_BLACK_BG}" "\x1B[40m"
}

test_constant_ansi_red_bg() {
    assertEquals "${ANSI_RED_BG}" "\x1B[41m"
}

test_constant_ansi_green_bg() {
    assertEquals "${ANSI_GREEN_BG}" "\x1B[42m"
}

test_constant_ansi_yellow_bg() {
    assertEquals "${ANSI_YELLOW_BG}" "\x1B[43m"
}

test_constant_ansi_blue_bg() {
    assertEquals "${ANSI_BLUE_BG}" "\x1B[44m"
}

test_constant_ansi_magenta_bg() {
    assertEquals "${ANSI_MAGENTA_BG}" "\x1B[45m"
}

test_constant_ansi_cyan_bg() {
    assertEquals "${ANSI_CYAN_BG}" "\x1B[46m"
}

test_constant_ansi_white_bg() {
    assertEquals "${ANSI_WHITE_BG}" "\x1B[47m"
}

test_constant_ansi_default_bg() {
    assertEquals "${ANSI_DEFAULT_BG}" "\x1B[49m"
}

test_constant_ansi_bright_black() {
    assertEquals "${ANSI_BRIGHT_BLACK}" "\x1B[90m"
}

test_constant_ansi_bright_red() {
    assertEquals "${ANSI_BRIGHT_RED}" "\x1B[91m"
}

test_constant_ansi_bright_green() {
    assertEquals "${ANSI_BRIGHT_GREEN}" "\x1B[92m"
}

test_constant_ansi_bright_yellow() {
    assertEquals "${ANSI_BRIGHT_YELLOW}" "\x1B[93m"
}

test_constant_ansi_bright_blue() {
    assertEquals "${ANSI_BRIGHT_BLUE}" "\x1B[94m"
}

test_constant_ansi_bright_magenta() {
    assertEquals "${ANSI_BRIGHT_MAGENTA}" "\x1B[95m"
}

test_constant_ansi_bright_cyan() {
    assertEquals "${ANSI_BRIGHT_CYAN}" "\x1B[96m"
}

test_constant_ansi_bright_white() {
    assertEquals "${ANSI_BRIGHT_WHITE}" "\x1B[97m"
}

test_constant_ansi_bright_black_bg() {
    assertEquals "${ANSI_BRIGHT_BLACK_BG}" "\x1B[100m"
}

test_constant_ansi_bright_red_bg() {
    assertEquals "${ANSI_BRIGHT_RED_BG}" "\x1B[101m"
}

test_constant_ansi_bright_green_bg() {
    assertEquals "${ANSI_BRIGHT_GREEN_BG}" "\x1B[102m"
}

test_constant_ansi_bright_yellow_bg() {
    assertEquals "${ANSI_BRIGHT_YELLOW_BG}" "\x1B[103m"
}

test_constant_ansi_bright_blue_bg() {
    assertEquals "${ANSI_BRIGHT_BLUE_BG}" "\x1B[104m"
}

test_constant_ansi_bright_magenta_bg() {
    assertEquals "${ANSI_BRIGHT_MAGENTA_BG}" "\x1B[105m"
}

test_constant_ansi_bright_cyan_bg() {
    assertEquals "${ANSI_BRIGHT_CYAN_BG}" "\x1B[106m"
}

test_constant_ansi_bright_white_bg() {
    assertEquals "${ANSI_BRIGHT_WHITE_BG}" "\x1B[107m"
}

# Load and run shUnit2
. shunit2
