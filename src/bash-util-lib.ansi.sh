#!/usr/bin/env bash

# @file  Bash-Util-Lib (ANSI)
# @brief Bash Utility Library (ANSI)


if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)ANSI(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_DATE="2022-11-09 17:04:48"
    BASH_UTIL_LIB_MODULES="ANSI:${BASH_UTIL_LIB_MODULES}"

    source "$(dirname "${BASH_SOURCE[0]}")/bash-util-lib.ansi.const.sh"


    ES_USE=true

    NC_USE=true
    CMD_TPUT="$(command -v tput)"

    # @description  Output escape sequence with provided control code if **`ES_USE`** environment variable is true
    #
    # @arg  CONTROL_CODE string - Argument to pass to escape sequence
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence control code
    function ansi::es() {
        local CONTROL_CODE="$1"

        case "${ES_USE}" in
            0|true) ES_USE=true ;;
            *)      ES_USE=false ;;
        esac

        if ${ES_USE}; then
            printf "%b%s" "${ANSI_CSI}" "${CONTROL_CODE}"
            return $?
        else
            return 1
        fi
    }

    # @description  Output escape sequence with provided color code for foreground, background, or underline
    #
    # @arg  COLOR integer - Escape sequence color integer (0 - 255)
    # @arg  ROLE  string  - [OPTIONAL] Role of color to change
    #           f  Foreground color [DEFAULT]
    #           b  Background color
    #           u  Underline color
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence color code output
    function ansi::es::color() {
        local COLOR="$1"
        local ROLE="$2"

        ROLE="$(echo "${ROLE}" | tr '[:upper:]' '[:lower:]')"

        case "${ROLE}" in
            u*)   ROLE="58" ;;
            b*)   ROLE="48" ;;
            f*|*) ROLE="38" ;;
        esac

        ansi::es "${ROLE};5;${COLOR}m"
        return $?
    }

    # @description  Output escape sequence with provided red, green, blue color code for foreground, background, or underline
    #
    # @arg  R    integer - Escape sequence red color integer (0 - 255)
    # @arg  G    integer - Escape sequence green color integer (0 - 255)
    # @arg  B    integer - Escape sequence blue color integer (0 - 255)
    # @arg  ROLE string  - [OPTIONAL] Role of color to change
    #           f  Foreground color [DEFAULT]
    #           b  Background color
    #           u  Underline color
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence color code output
    function ansi::es::colorRgb() {
        local R="$1"
        local G="$2"
        local B="$3"
        local ROLE="$4"

        ROLE="$(echo "${ROLE}" | tr '[:upper:]' '[:lower:]')"

        case "${ROLE}" in
            u*)   ROLE="58" ;;
            b*)   ROLE="48" ;;
            f*|*) ROLE="38" ;;
        esac

        ansi::es "${ROLE};2;${R};${G};${B}m"
        return $?
    }

    # @description  Output escape sequence with provided HEX color code for foreground, background, or underline
    #
    # @arg  HEX  string - Escape sequence color in HEX [RRGGBB] (00 - FF)
    # @arg  ROLE string - [OPTIONAL] Role of color to change
    #           f  Foreground color [DEFAULT]
    #           b  Background color
    #           u  Underline color
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence color code output
    function ansi::es::colorHex() {
        local HEX=${1#"#"}
        local ROLE="$2"
        local R G B

        R="$(printf "%d\n" "$(printf '0x%0.2s' "${HEX}")")"
        G="$(printf "%d\n" "$(printf '0x%0.2s' "${HEX#??}")")"
        B="$(printf "%d\n" "$(printf '0x%0.2s' "${HEX#????}")")"

        ansi::es::colorRgb "${R}" "${G}" "${B}" "${ROLE}"
        return $?
    }

    # @description  Output escape sequence with provided text attribute control code
    #
    # @arg  CONTROL_CODE string - [OPTIONAL] Escape sequence text attribute control code
    #           underline-off    Underline color off
    #           background-off   Background color off
    #           foreground-off   Foreground color off
    #           overline-reset   Overline text
    #           strike-reset     Strike-through text
    #           hidden-reset     Hidden text
    #           swap-reset       Swap foreground and background colors
    #           blink-reset      Slow blink
    #           underline-reset  Underline text
    #           italic-reset     Italic text
    #           faint-reset      Faint text
    #           bold-reset       Bold text
    #           overline         Overline text
    #           strike           Strike-through text
    #           hidden           Hidden text
    #           swap             Swap foreground and background colors
    #           fast-blink       Fast blink
    #           blink            Slow blink
    #           underline        Underline text
    #           italic           Italic text
    #           faint            Faint text
    #           bold             Bold text
    #           reset            Reset text formatting and colors [DEFAULT]
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence text attribute control code output
    function ansi::es::attrib() {
        local CONTROL_CODE="$1"

        CONTROL_CODE="$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')"

        case "${CONTROL_CODE}" in
              underline-off)   CONTROL_CODE="59m" ;;
             background-off)   CONTROL_CODE="49m" ;;
             foreground-off)   CONTROL_CODE="39m" ;;
             overline-reset)   CONTROL_CODE="55m" ;;
               strike-reset)   CONTROL_CODE="29m" ;;
               hidden-reset)   CONTROL_CODE="28m" ;;
                 swap-reset)   CONTROL_CODE="27m" ;;
                blink-reset)   CONTROL_CODE="25m" ;;
            underline-reset)   CONTROL_CODE="24m" ;;
               italic-reset)   CONTROL_CODE="23m" ;;
                faint-reset)   CONTROL_CODE="22m" ;;
                 bold-reset)   CONTROL_CODE="22m" ;;
                   overline)   CONTROL_CODE="53m" ;;
                     strike)   CONTROL_CODE="9m" ;;
                     hidden)   CONTROL_CODE="8m" ;;
                       swap)   CONTROL_CODE="7m" ;;
                 fast-blink)   CONTROL_CODE="6m" ;;
                      blink)   CONTROL_CODE="5m" ;;
                  underline)   CONTROL_CODE="4m" ;;
                     italic)   CONTROL_CODE="3m" ;;
                      faint)   CONTROL_CODE="2m" ;;
                       bold)   CONTROL_CODE="1m" ;;
                      reset|*) CONTROL_CODE="0m" ;;
        esac

        ansi::es "${CONTROL_CODE}"
        return $?
    }

    # @description  Output escape sequence with provided erase control code
    #
    # @arg  CONTROL_CODE string - [OPTIONAL] Escape sequence erase control code
    #           eol    Erase from cursor position to end of line
    #           sol    Erase from cursor position to start of line
    #           cur    Erase the entire current line
    #           bottom Erase from the current line to the bottom of the screen
    #           top    Erase from the current line to the top of the screen
    #           clear  Clear the screen [DEFAULT]
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence erase control code output
    function ansi::es::erase() {
        local CONTROL_CODE="$1"

        CONTROL_CODE="$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')"

        case "${CONTROL_CODE}" in
               eol)   CONTROL_CODE="0K" ;;
               sol)   CONTROL_CODE="1K" ;;
               cur)   CONTROL_CODE="2K" ;;
            bottom)   CONTROL_CODE="0J" ;;
               top)   CONTROL_CODE="1J" ;;
             clear|*) CONTROL_CODE="2J" ;;
        esac

        ansi::es "${CONTROL_CODE}"
        return $?
    }

    # @description  Output escape sequence with provided cursor control code
    #
    # @arg  CONTROL_CODE string  - [OPTIONAL] Escape sequence cursor control code
    #           abs        Move cursor to absolute position line _N_ column _N_
    #           up         Move cursor up _N_ lines
    #           down       Move cursor down _N_ lines
    #           right      Move cursor right _N_ columns
    #           left       Move cursor left _N_ columns
    #           begin-down Move cursor to beginning and down _N_ lines
    #           begin-up   Move cursor to beginning and up _N_ lines
    #           column     Move cursor to column _N_
    #           save       Save cursor position
    #           restore    Restore cursor position
    #           home       Move cursor to home position (0, 0) [DEFAULT]
    # @arg  VAL1         integer - [OPTIONAL] First value for CONTROL_CODE
    # @arg  VAL2         integer - [OPTIONAL] Second value for CONTROL_CODE
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence cursor control code output
    function ansi::es::cursor() {
        local CONTROL_CODE="$1"
        local VAL1="${2:-0}"
        local VAL2="${3:-0}"

        CONTROL_CODE="$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')"

        case "${CONTROL_CODE}" in
                   abs)   CONTROL_CODE="${VAL1};${VAL2}" ;;
                    up)   CONTROL_CODE="${VAL1}A" ;;
                  down)   CONTROL_CODE="${VAL1}B" ;;
                 right)   CONTROL_CODE="${VAL1}C" ;;
                  left)   CONTROL_CODE="${VAL1}D" ;;
            begin-down)   CONTROL_CODE="${VAL1}E" ;;
              begin-up)   CONTROL_CODE="${VAL1}F" ;;
                column)   CONTROL_CODE="${VAL1}G" ;;
                  save)   CONTROL_CODE="s" ;;
               restore)   CONTROL_CODE="u" ;;
                  home|*) CONTROL_CODE="H" ;;
        esac

        ansi::es "${CONTROL_CODE}"
        return $?
    }

    # @description  Call ncurses `tput` command with provided arguments if command exists (**`CMD_TPUT`**) and **`NC_USE`**` environment variable is true
    #
    # @arg  @ array - Arguments to pass to ncurses command `tput`
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses `tput` output
    function ansi::nc() {
        case "${NC_USE}" in
            0|true) NC_USE=true ;;
            *)      NC_USE=false ;;
        esac

        if ! ${NC_USE} || [[ -z "${CMD_TPUT}" ]]; then
            return 1
        else
            # shellcheck disable=SC2068 # Double quote array expansions to avoid re-splitting elements.
            "${CMD_TPUT}" $@
            return $?
        fi
    }

    # @description  Output ncurses color code for foreground or background
    #
    # @arg  COLOR integer - ncurses color integer (0 - 255)
    # @arg  ROLE  string  - [OPTIONAL] Role of color to change
    #           f  Foreground [DEFAULT]
    #           b  Background
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses `tput` color code output
    function ansi::nc::color() {
        local COLOR="$1"
        local ROLE="$2"
        local CAP_NAME

        ROLE="$(echo "${ROLE}" | tr '[:upper:]' '[:lower:]')"

        case "${ROLE}" in
            b*)   CAP_NAME="setab" ;;
            f*|*) CAP_NAME="setaf" ;;
        esac

        ansi::nc "${CAP_NAME}" "${COLOR}"
        return $?
    }

    # @description  Output ncurses sequence with provided text attribute control code
    #
    # @arg  CONTROL_CODE string - [OPTIONAL] ncurses sequence text attribute control code
    #           standout      Standout
    #           standout-off  Standout off
    #           invisible     Blank mode
    #           reverse       Swap foreground and background colors
    #           blink         Slow blink
    #           underline     Underline text
    #           underline-off Underline text off
    #           italic        Italic text
    #           dim           Dim text
    #           bold          Bold text
    #           reset         Reset all attributes [DEFAULT]
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses sequence text attribute control code output
    function ansi::nc::attrib() {
        local CONTROL_CODE="$1"

        CONTROL_CODE="$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')"

        case "${CONTROL_CODE}" in
                 standout)   CONTROL_CODE="smso" ;;
             standout-off)   CONTROL_CODE="rmso" ;;
                invisible)   CONTROL_CODE="invis" ;;
                  reverse)   CONTROL_CODE="rev" ;;
                    blink)   CONTROL_CODE="blink" ;;
                underline)   CONTROL_CODE="smul" ;;
            underline-off)   CONTROL_CODE="rmul" ;;
                   italic)   CONTROL_CODE="sitm" ;;
                      dim)   CONTROL_CODE="dim" ;;
                     bold)   CONTROL_CODE="bold" ;;
                    reset|*) CONTROL_CODE="sgr0" ;;
        esac

        ansi::nc "${CONTROL_CODE}"
        return $?
    }

    # @description  Output ncurses sequence with provided erase control code
    #
    # @arg  CONTROL_CODE string  - [OPTIONAL] ncurses sequence erase control code
    #           sol    Erase from cursor position to start of line
    #           eol    Erase from cursor position to end of line
    #           eos    Erase from cursor position to end of screen
    #           en     Erase from cursor _N_ characters
    #           ic     Insert from cursor _N_ characters (moves rest of characters in line)
    #           il     Insert from cursor _N_ lines (moves rest of lines on screen)
    #           clear  Clear the screen [DEFAULT]
    # @arg  VAL          integer - [OPTIONAL] Value for CONTROL_CODE
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses sequence erase control code output
    function ansi::nc::erase() {
        local CONTROL_CODE="$1"
        local VAL="${2:-0}"

        CONTROL_CODE="$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')"

        case "${CONTROL_CODE}" in
               sol)   CONTROL_CODE="el1" ;;
               eol)   CONTROL_CODE="el" ;;
               eos)   CONTROL_CODE="ed" ;;
                en)   CONTROL_CODE="ech ${VAL}" ;;
                ic)   CONTROL_CODE="ich ${VAL}" ;;
                il)   CONTROL_CODE="il ${VAL}" ;;
             clear|*) CONTROL_CODE="clear" ;;
        esac

        ansi::nc "${CONTROL_CODE}"
        return $?
    }

    # @description  Output ncurses sequence with provided cursor control code
    #
    # @arg  CONTROL_CODE  string  - [OPTIONAL] ncurses sequence cursor control code
    #           save          Save cursor position
    #           restore       Restore cursor position
    #           invisible     Make cursor invisible
    #           invisible-off Make cursor visible
    #           up            Move cursor up 1 line
    #           down          Move cursor down 1 line
    #           left          Move cursor left _N_ columns
    #           right         Move cursor right _N_ columns
    #           abs           Move cursor to absolute position line _N_ column _N_
    #           home          Move cursor to home position (0, 0) [DEFAULT]
    # @arg  VAL1         integer - [OPTIONAL] First value for CONTROL_CODE
    # @arg  VAL2         integer - [OPTIONAL] Second value for CONTROL_CODE
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses sequence cursor control code output
    function ansi::nc::cursor() {
        local CONTROL_CODE="$1"
        local VAL1="${2:-0}"
        local VAL2="${3:-0}"

        CONTROL_CODE="$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')"

        case "${CONTROL_CODE}" in
                     save)   CONTROL_CODE="sc" ;;
                  restore)   CONTROL_CODE="rc" ;;
                invisible)   CONTROL_CODE="civis" ;;
            invisible-off)   CONTROL_CODE="cvvis" ;;
                       up)   CONTROL_CODE="cuu1" ;;
                     down)   CONTROL_CODE="cud1" ;;
                     left)   CONTROL_CODE="cub ${VAL1}" ;;
                    right)   CONTROL_CODE="cuf ${VAL1}" ;;
                      abs)   CONTROL_CODE="cup '${VAL1};${VAL2}'" ;;
                     home|*) CONTROL_CODE="home" ;;
        esac

        ansi::nc "${CONTROL_CODE}"
        return $?
    }
fi
