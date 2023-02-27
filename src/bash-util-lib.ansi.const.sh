#!/usr/bin/env bash

# @file  Bash-Util-Lib (ANSI Constants)
# @brief Bash Utility Library (ANSI Constants)

# shellcheck disable=SC2034 # foo appears unused. Verify it or export it.


if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)ANSI\.CONST(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_MODULES="ANSI.CONST:${BASH_UTIL_LIB_MODULES}"


    ## ANSI Escape Sequences
    declare -r ANSI_ESC="\x1B"
    declare -r ANSI_CSI="${ANSI_ESC}["
    declare -r ANSI_DCS="${ANSI_ESC}P"
    declare -r ANSI_OSC="${ANSI_ESC}]"

    ## ANSI Text Modifier Reset (Including Colors)
    declare -r ANSI_RESET="${ANSI_CSI}0m"

    ## ANSI Text Modifiers
    declare -r ANSI_BOLD="${ANSI_CSI}1m"
    declare -r ANSI_FAINT="${ANSI_CSI}2m"
    declare -r ANSI_ITALIC="${ANSI_CSI}3m"
    declare -r ANSI_UNDERLINE="${ANSI_CSI}4m"
    declare -r ANSI_BLINK="${ANSI_CSI}5m"
    declare -r ANSI_BLINK_FAST="${ANSI_CSI}6m"
    declare -r ANSI_SWAP="${ANSI_CSI}7m"
    declare -r ANSI_HIDDEN="${ANSI_CSI}8m"
    declare -r ANSI_STRIKE="${ANSI_CSI}9m"
    declare -r ANSI_OVERLINE="${ANSI_CSI}53m"

    ## ANSI Text Modifier Rests
    declare -r ANSI_BOLD_RESET="${ANSI_CSI}22m"
    declare -r ANSI_FAINT_RESET="${ANSI_CSI}22m"
    declare -r ANSI_ITALIC_RESET="${ANSI_CSI}23m"
    declare -r ANSI_UNDERLINE_RESET="${ANSI_CSI}24m"
    declare -r ANSI_BLINK_RESET="${ANSI_CSI}25m"
    declare -r ANSI_SWAP_RESET="${ANSI_CSI}27m"
    declare -r ANSI_HIDDEN_RESET="${ANSI_CSI}28m"
    declare -r ANSI_STRIKE_RESET="${ANSI_CSI}29m"
    declare -r ANSI_OVERLINE_RESET="${ANSI_CSI}55m"

    ## ANSI Text Foreground Colors
    declare -r ANSI_BLACK="${ANSI_CSI}30m"
    declare -r ANSI_RED="${ANSI_CSI}31m"
    declare -r ANSI_GREEN="${ANSI_CSI}32m"
    declare -r ANSI_YELLOW="${ANSI_CSI}33m"
    declare -r ANSI_BLUE="${ANSI_CSI}34m"
    declare -r ANSI_MAGENTA="${ANSI_CSI}35m"
    declare -r ANSI_CYAN="${ANSI_CSI}36m"
    declare -r ANSI_WHITE="${ANSI_CSI}37m"

    ## ANSI Text Foreground Color Reset
    declare -r ANSI_DEFAULT="${ANSI_CSI}39m"

    ## ANSI Text Background Colors
    declare -r ANSI_BLACK_BG="${ANSI_CSI}40m"
    declare -r ANSI_RED_BG="${ANSI_CSI}41m"
    declare -r ANSI_GREEN_BG="${ANSI_CSI}42m"
    declare -r ANSI_YELLOW_BG="${ANSI_CSI}43m"
    declare -r ANSI_BLUE_BG="${ANSI_CSI}44m"
    declare -r ANSI_MAGENTA_BG="${ANSI_CSI}45m"
    declare -r ANSI_CYAN_BG="${ANSI_CSI}46m"
    declare -r ANSI_WHITE_BG="${ANSI_CSI}47m"

    ## ANSI Text Background Color Reset
    declare -r ANSI_DEFAULT_BG="${ANSI_CSI}49m"

    ## ANSI Text Foreground Bright Colors
    declare -r ANSI_BRIGHT_BLACK="${ANSI_CSI}90m"
    declare -r ANSI_BRIGHT_RED="${ANSI_CSI}91m"
    declare -r ANSI_BRIGHT_GREEN="${ANSI_CSI}92m"
    declare -r ANSI_BRIGHT_YELLOW="${ANSI_CSI}93m"
    declare -r ANSI_BRIGHT_BLUE="${ANSI_CSI}94m"
    declare -r ANSI_BRIGHT_MAGENTA="${ANSI_CSI}95m"
    declare -r ANSI_BRIGHT_CYAN="${ANSI_CSI}96m"
    declare -r ANSI_BRIGHT_WHITE="${ANSI_CSI}97m"

    ## ANSI Text Background Bright Colors
    declare -r ANSI_BRIGHT_BLACK_BG="${ANSI_CSI}100m"
    declare -r ANSI_BRIGHT_RED_BG="${ANSI_CSI}101m"
    declare -r ANSI_BRIGHT_GREEN_BG="${ANSI_CSI}102m"
    declare -r ANSI_BRIGHT_YELLOW_BG="${ANSI_CSI}103m"
    declare -r ANSI_BRIGHT_BLUE_BG="${ANSI_CSI}104m"
    declare -r ANSI_BRIGHT_MAGENTA_BG="${ANSI_CSI}105m"
    declare -r ANSI_BRIGHT_CYAN_BG="${ANSI_CSI}106m"
    declare -r ANSI_BRIGHT_WHITE_BG="${ANSI_CSI}107m"
fi
