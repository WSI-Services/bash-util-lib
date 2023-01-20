#!/usr/bin/env bash

# @file  Bash-Util-Lib (ANSI)
# @brief Bash Utility Library (ANSI)

# shellcheck disable=SC2034 # foo appears unused. Verify it or export it.


if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)ANSI(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_MODULES="ANSI:${BASH_UTIL_LIB_MODULES}"

    source "$(dirname "${BASH_SOURCE[0]}")/bash-util-lib.ansi.const.sh"


    ES_USE=true

    # @description  Output escape sequence with provided control code if **`ES_USE`** environment variable is true
    #
    # @arg  CONTROL_CODE string - Argument to pass to escape sequence
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence control code
    es() {
        local CONTROL_CODE="$1"

        case "${ES_USE}" in
            0|true) ES_USE=true ;;
            *)      ES_USE=false ;;
        esac

        if ${ES_USE}; then
            printf "\033[%s" "${CONTROL_CODE}"
            return $?
        else
            return 0
        fi
    }

    # @description  Output escape sequence with provided color code for foreground or background
    #
    # @arg  COLOR string - escape sequence color integer (0 - 255)
    # @arg  FG_BG string - [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence color code output
    es_color() {
        local COLOR="$1"
        local FG_BG="$2"
        local CONTROL_CODE

        case "$(echo "${FG_BG}" | tr '[:upper:]' '[:lower:]')" in
            b*)   CONTROL_CODE="48" ;;
            f*|*) CONTROL_CODE="38" ;;
        esac

        es "${CONTROL_CODE};5;${COLOR}m"
        return $?
    }

    # @description  Output escape sequence with provided red, green, blue color code for foreground or background
    #
    # @arg  R     integer - Red color integer (0 - 255)
    # @arg  G     integer - Green color integer (0 - 255)
    # @arg  B     integer - Blue color integer (0 - 255)
    # @arg  FG_BG string  - [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence color code output
    es_color_rgb() {
        local R="$1"
        local G="$2"
        local B="$3"
        local FG_BG="$4"
        local CONTROL_CODE

        case "$(echo "${FG_BG}" | tr '[:upper:]' '[:lower:]')" in
            b*)   CONTROL_CODE="48" ;;
            f*|*) CONTROL_CODE="38" ;;
        esac

        es "${CONTROL_CODE};2;${R};${G};${B}m"
        return $?
    }

    # @description  Output escape sequence with provided HEX color code for foreground or background
    #
    # @arg  HEX   string - Escape sequence color in HEX [RRGGBB] (00 - FF)
    # @arg  FG_BG string - [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence color code output
    es_color_hex() {
        local HEX=${1#"#"}
        local FG_BG="$2"
        local CONTROL_CODE R G B

        R="$(printf "%d\n" "$(printf '0x%0.2s' "${HEX}")")"
        G="$(printf "%d\n" "$(printf '0x%0.2s' "${HEX#??}")")"
        B="$(printf "%d\n" "$(printf '0x%0.2s' "${HEX#????}")")"

        es_color_rgb "${R}" "${G}" "${B}" "${FG_BG}"
        return $?
    }

    # @description  Output escape sequence with provided text attribute control code
    #
    # @arg  CONTROL_CODE string - [OPTIONAL] Escape sequence text attribute control code
    #           strike    Strike-through text
    #           hidden    Hidden text
    #           swap      Swap foreground and background colors
    #           blink     Slow blink
    #           underline Underline text
    #           italic    Italic text
    #           fait      Faint text
    #           bold      Bold text
    #           reset     Reset text formatting and colors [DEFAULT]
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence text attribute control code output
    es_attrib() {
        local CONTROL_CODE="$1"

        case "$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')" in
               strike|9)   CONTROL_CODE="9m" ;;
               hidden|8)   CONTROL_CODE="8m" ;;
                 swap|7)   CONTROL_CODE="7m" ;;
                blink|5|6) CONTROL_CODE="5m" ;;
            underline|4)   CONTROL_CODE="4m" ;;
               italic|3)   CONTROL_CODE="3m" ;;
                faint|2)   CONTROL_CODE="2m" ;;
                 bold|1)   CONTROL_CODE="1m" ;;
                reset|0|*) CONTROL_CODE="0m" ;;
        esac

        es "${CONTROL_CODE}"
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
    es_erase() {
        local CONTROL_CODE="$1"

        case "$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')" in
               eol)   CONTROL_CODE="0K" ;;
               sol)   CONTROL_CODE="1K" ;;
               cur)   CONTROL_CODE="2K" ;;
            bottom)   CONTROL_CODE="0J" ;;
               top)   CONTROL_CODE="1J" ;;
             clear|*) CONTROL_CODE="2J" ;;
        esac

        es "${CONTROL_CODE}"
        return $?
    }

    # @description  Output escape sequence with provided cursor control code
    #
    # @arg  CONTROL_CODE string  - [OPTIONAL] Escape sequence cursor control code
    #           abs     Move cursor to absolute position line _N_ column _N_
    #           up      Move cursor up _N_ lines
    #           down    Move cursor down _N_ lines
    #           right   Move cursor right _N_ columns
    #           left    Move cursor left _N_ columns
    #           save    Save cursor position
    #           restore Restore cursor position
    #           home    Move cursor to home position (0, 0) [DEFAULT]
    # @arg  VAL1         integer - [OPTIONAL] First value for CONTROL_CODE
    # @arg  VAL2         integer - [OPTIONAL] Second value for CONTROL_CODE
    #
    # @exitcode  0  Command control code turned on and output sequence
    # @exitcode  1  Command control code turned off or failed
    #
    # @stdout  Specified escape sequence cursor control code output
    es_cursor() {
        local CONTROL_CODE="$1"
        local VAL1="${2:-0}"
        local VAL2="${3:-0}"

        case "$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')" in
                abs)   CONTROL_CODE="${VAL1};${VAL2}" ;;
                 up)   CONTROL_CODE="${VAL1}A" ;;
               down)   CONTROL_CODE="${VAL1}B" ;;
              right)   CONTROL_CODE="${VAL1}C" ;;
               left)   CONTROL_CODE="${VAL1}D" ;;
               save)   CONTROL_CODE="s" ;;
            restore)   CONTROL_CODE="u" ;;
               home|*) CONTROL_CODE="H" ;;
        esac

        es "${CONTROL_CODE}"
        return $?
    }

    CMD_TPUT="$(command -v tput)"
    NC_USE=true

    # @description  Call ncurses `tput`` command with provided arguments if command exists (**`CMD_TPUT`**) and **`NC_USE`**` environment variable is true
    #
    # @arg  @ array - Arguments to pass to ncurses command `tput`
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses `tput` output
    nc() {
        case "${NC_USE}" in
            0|true) NC_USE=true ;;
            *)      NC_USE=false ;;
        esac

        if [[ -z "${CMD_TPUT}" ]]; then
            return 1
        elif ${NC_USE}; then
            "${CMD_TPUT}" "${@}"
            return $?
        fi
    }

    # @description  Output ncurses color code for foreground or background
    #
    # @arg  COLOR integer - ncurses color integer
    # @arg  FG_BG string  - [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses `tput`` color code output
    nc_color() {
        local COLOR="$1"
        local FG_BG="$2"
        local CAP_NAME

        case "$(echo "${FG_BG}" | tr '[:upper:]' '[:lower:]')" in
            b*)   CAP_NAME="setab" ;;
            f*|*) CAP_NAME="setaf" ;;
        esac

        nc "${CAP_NAME}" "${COLOR}"
        return $?
    }

    # @description  Output ncurses color index code from HEX
    #
    # @arg  HEX string - HEX color code [RRGGBB] (00 - FF)
    #
    # @exitcode  0  HEX value provided
    # @exitcode  1  HEX value not provided
    #
    # @stdout  Specified ncurses color index code
    nc_color_from_hex() {
        local HEX=${1#"#"}
        local R G B RGB

        if [[ -z "${HEX}" ]]; then
            return 1
        fi

        R="$(printf '0x%0.2s' "${HEX}")"
        G="$(printf '0x%0.2s' "${HEX#??}")"
        B="$(printf '0x%0.2s' "${HEX#????}")"

        RGB="(R<75?0:(R-35)/40)*6*6"
        RGB="${RGB} + (G<75?0:(G-35)/40)*6"
        RGB="${RGB} + (B<75?0:(B-35)/40) + 16"
        RGB="$(printf '%03d' "$(( RGB ))")"

        printf '%i' "${RGB}"
        return $?
    }

    # @description  Output ncurses color code in HEX for foreground or background
    #
    # @arg  HEX   string - HEX color code [RRGGBB] (00 - FF)
    # @arg  FG_BG string - [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
    #
    # @exitcode  0  Command `tput` exists
    # @exitcode  1  Command `tput` turned off, missing, or failed
    #
    # @stdout  Specified ncurses `tput`` color code output
    nc_color_hex() {
        local HEX="$1"
        local FG_BG="$2"
        local COLOR

        COLOR="$(nc_color_from_hex "${HEX}")"

        nc_color "${COLOR}" "${FG_BG}"
        return $?
    }
fi
