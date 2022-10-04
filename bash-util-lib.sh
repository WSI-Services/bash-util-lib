#!/usr/bin/env bash

# @file  Bash-Util-Lib
# @brief Bash Utility Library


ES_USE=true

# @description  Output escape sequence with provided control code if ES_USE environment variable is true
#
# @arg  $CONTROL_CODE string - Argument to pass to escape sequence
#
# @exitcode  0  Command control code turned off or failed
# @exitcode  1  Command control code turned on and output sequence
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
# @arg  $COLOR string - escape sequence color integer
# @arg  $FG_BG string - Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
#
# @exitcode  0  Command control code turned off or failed
# @exitcode  1  Command control code turned on and output sequence
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
# @arg  $R     integer - Red color integer
# @arg  $G     integer - Green color integer
# @arg  $B     integer - Blue color integer
# @arg  $FG_BG string  - Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
#
# @exitcode  0  Command control code turned off or failed
# @exitcode  1  Command control code turned on and output sequence
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
# @arg  $HEX   string - escape sequence color in HEX
# @arg  $FG_BG string - Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
#
# @exitcode  0  Command control code turned off or failed
# @exitcode  1  Command control code turned on and output sequence
#
# @stdout  Specified escape sequence color code output
es_color_hex() {
    local HEX=${1#"#"}
    local FG_BG="$2"
    local CONTROL_CODE R G B

    R=$(printf "%d\n" "$(printf '0x%0.2s' "${HEX}")")
    G=$(printf "%d\n" "$(printf '0x%0.2s' "${HEX#??}")")
    B=$(printf "%d\n" "$(printf '0x%0.2s' "${HEX#????}")")

    es_color_rgb "${R}" "${G}" "${B}" "${FG_BG}"
    return $?
}

# @description  Output escape sequence with provided text attribute control code
#
# @arg  $CONTROL_CODE string - escape sequence text attribute control code
#           strike    Strike-through text
#           hidden    Hidden text
#           swap      Swap foreground and background colors
#           blink     Slow blink
#           underline Underline text
#           italic    Italic text
#           fait      Faint text
#           bold      Bold text
#           reset     Reset text formatting and colors
#
# @exitcode  0  Command control code turned off or failed
# @exitcode  1  Command control code turned on and output sequence
#
# @stdout  Specified escape sequence text attribute control code output
es_attrib() {
    local CONTROL_CODE="$1"

    case "$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')" in
           strike|9)   CONTROL_CODE="9m" ;; # Strike-through text
           hidden|8)   CONTROL_CODE="8m" ;; # Hidden text
             swap|7)   CONTROL_CODE="7m" ;; # Swap foreground and background colors
          blink|5|6)   CONTROL_CODE="5m" ;; # Slow blink
        underline|4)   CONTROL_CODE="4m" ;; # Underline text
           italic|3)   CONTROL_CODE="3m" ;; # Italic text
            faint|2)   CONTROL_CODE="2m" ;; # Faint text
             bold|1)   CONTROL_CODE="1m" ;; # Bold text
            reset|0|*) CONTROL_CODE="0m" ;; # Reset text formatting and colors
    esac

    es "${CONTROL_CODE}"
    return $?
}

# @description  Output escape sequence with provided erase control code
#
# @arg  $CONTROL_CODE string - escape sequence erase control code
#           eol    Erase from cursor position to end of line
#           sol    Erase from cursor position to start of line
#           cur    Erase the entire current line
#           bottom Erase from the current line to the bottom of the screen
#           top    Erase from the current line to the top of the screen
#           clear  Clear the screen
#
# @exitcode  0  Command control code turned off or failed
# @exitcode  1  Command control code turned on and output sequence
#
# @stdout  Specified escape sequence erase control code output
es_erase() {
    local CONTROL_CODE="$1"

    case "$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')" in
           eol)   CONTROL_CODE="0K" ;; # Erase from cursor position to end of line
           sol)   CONTROL_CODE="1K" ;; # Erase from cursor position to start of line
           cur)   CONTROL_CODE="2K" ;; # Erase the entire current line
        bottom)   CONTROL_CODE="0J" ;; # Erase from the current line to the bottom of the screen
           top)   CONTROL_CODE="1J" ;; # Erase from the current line to the top of the screen
         clear|*) CONTROL_CODE="2J" ;; # Clear the screen
    esac

    es "${CONTROL_CODE}"
    return $?
}

# @description  Output escape sequence with provided cursor control code
#
# @arg  $CONTROL_CODE string - Escape sequence cursor control code
#           abs     Move cursor to absolute position (LINE;COLUMN)
#           up      Move cursor up N lines (NUM)
#           down    Move cursor down N lines (NUM)
#           right   Move cursor right N columns (NUM)
#           left    Move cursor left N columns (NUM)
#           save    Save cursor position
#           restore Restore cursor position
#           home    Move cursor to home position (0,0)
# @arg  $VAL1         integer - Optional value for CONTROL_CODE
# @arg  $VAL2         integer - Optional value for CONTROL_CODE
#
# @exitcode  0  Command control code turned off or failed
# @exitcode  1  Command control code turned on and output sequence
#
# @stdout  Specified escape sequence cursor control code output
es_cursor() {
    local CONTROL_CODE="$1"
    local VAL1="${2:-0}"
    local VAL2="${3:-0}"

    case "$(echo "${CONTROL_CODE}" | tr '[:upper:]' '[:lower:]')" in
            abs)   CONTROL_CODE="${VAL1};${VAL2}" ;; # Move cursor to absolute position
             up)   CONTROL_CODE="${VAL1}A" ;;        # Move cursor up N lines
           down)   CONTROL_CODE="${VAL1}B" ;;        # Move cursor down N lines
          right)   CONTROL_CODE="${VAL1}C" ;;        # Move cursor right N columns
           left)   CONTROL_CODE="${VAL1}D" ;;        # Move cursor left N columns
           save)   CONTROL_CODE="s" ;;               # Save cursor position
        restore)   CONTROL_CODE="u" ;;               # Restore cursor position
           home|*) CONTROL_CODE="H" ;;               # Move cursor to home position (0,0)
    esac

    es "${CONTROL_CODE}"
    return $?
}


CMD_TPUT="$(which tput)"
NC_USE=true

# @description  Call ncurses tput command with provided arguments if command exists and NC_USE environment variable is true
#
# @arg  $@ array - Arguments to pass to ncurses command tput
#
# @exitcode  0  Command tput exists
# @exitcode  1  Command tput missing
#
# @stdout  Specified ncurses tput output
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
# @arg  $COLOR string - ncurses color integer
# @arg  $FG_BG string - Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else
#
# @exitcode  0  Command tput exists
# @exitcode  1  Command tput missing
#
# @stdout  Specified ncurses tput color code output
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
# @arg  $HEX string - HEX color code (RRGGBB) without number sign
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

    R=$(printf '0x%0.2s' "${HEX}")
    G=$(printf '0x%0.2s' "${HEX#??}")
    B=$(printf '0x%0.2s' "${HEX#????}")

    RGB="(R<75?0:(R-35)/40)*6*6"
    RGB="${RGB} + (G<75?0:(G-35)/40)*6"
    RGB="${RGB} + (B<75?0:(B-35)/40) + 16"
    RGB="$(printf '%03d' "$(( RGB ))")"

    printf '%i' "${RGB}"
    return $?
}


EXIT_ERR_MSG_ERROR="Error [%i]: %b\n"
EXIT_ERR_MSG_COMMAND="Command failed: %b\n"
EXIT_ERR_MSG_ADDITIONAL="%s\n"
UTIL_SCRIPT_CMD=""

# @description  Output provided error message, optionally additional message, and exit with provided code
#
# @arg  $ERR_CODE integer - Exit code
# @arg  $ERR_MSG  string  - Message to output
# @arg  $ADD_MSG  string  - [OPTIONAL] Additional message to output
#
# @exitcode  ?  Provided ERR_CODE argument
#
# @stderr  Provided ERR_CODE, ERR_MSG, optional UTIL_SCRIPT_CMD
# @stdout  [OPTIONAL] Provided additional message
exit_err() {
    local ERR_CODE="$1"
    local ERR_MSG="$2"
    local ADD_MSG="$3"

    >&2 printf "${EXIT_ERR_MSG_ERROR}" "${ERR_CODE}" "${ERR_MSG}"

    if [[ -n "${UTIL_SCRIPT_CMD}" ]]; then
        >&2 printf "${EXIT_ERR_MSG_COMMAND}" "${UTIL_SCRIPT_CMD}"
    fi

    if [[ -n "${ADD_MSG}" ]]; then
        printf "${EXIT_ERR_MSG_ADDITIONAL}" "${ADD_MSG}"
    fi

    exit "${ERR_CODE}"
}


# @description  Output last line number in provided file which matches provided pattern
#
# @arg  $FILE_NAME string - File to scan for pattern
# @arg  $PATTERN   string - Pattern to scan file for
#
# @exitcode  0  Line found
# @exitcode  1  Line not found
#
# @stdout  Line number of last matching line pattern
file_find_line() {
    local FILE_NAME="$1"
    local PATTERN="$2"
    local LINES

    LINES="$(grep -wn "${PATTERN}" "${FILE_NAME}")"
    [[ -z "${LINES}" ]] && return 1

    LINES="$(printf '%s' "${LINES}" | cut -d: -f1)"
    [[ -z "${LINES}" ]] && return 1

    printf '%s' "${LINES}" | tail -n1
    return $?
}

# @description  Output lines of provided file from provided start line till provided stop line
#
# @arg  $FILE_NAME  string  - File to clip lines from
# @arg  $START_LINE integer - Line number to begin clip
# @arg  $STOP_LINE  integer - Line number to end clip
#
# @exitcode  0  Lines found
# @exitcode  1  Lines not found
#
# @stdout  Specified lines from file
file_get_lines() {
    local FILE_NAME="$1"
    local START_LINE=$2
    local STOP_LINE=$3
    local LINES

    LINES="$(sed -n "${START_LINE},${STOP_LINE}p" "${FILE_NAME}")"
    [[ -z "${LINES}" ]] && return 1

    printf '%s' "${LINES}"
    return $?
}

# @description  Output provided input processed to expand variables
#
# @arg  $INPUT string - Text to evaluate for expansion
#
# @exitcode  0  String expanded
# @exitcode  1  String missing
#
# @stdout  Specified string expanded 
string_expand() {
    local INPUT="$1"
    local LINES

    LINES="$(eval "printf '%b' \"${INPUT}\"")"
    [[ -z "${LINES}" ]] && return 1

    printf '%s' "${LINES}"
    return $?
}

# @description  Output text from section in file specified by provided patterns
#
# @arg  $START_PATTERN string - Pattern of the start line to output
# @arg  $STOP_PATTERN  string - Pattern of the stop line to output
# @arg  $FILE_NAME     string - File to clip lines from
#
# @exitcode  0  Lines found and expanded
# @exitcode  1  Lines not found
#
# @stdout  Specified lines from file expanded 
file_expand_lines() {
    local FILE_NAME="$1"
    local START_PATTERN="$2"
    local STOP_PATTERN="$3"
    local START_LINE
    local STOP_LINE
    local LINES

    START_LINE=$(file_find_line "${FILE_NAME}" "${START_PATTERN}")
    STOP_LINE=$(file_find_line "${FILE_NAME}" "${STOP_PATTERN}")

    START_LINE=$((START_LINE+1))
    STOP_LINE=$((STOP_LINE-1))

    if [[ "${START_LINE}" -gt 0 ]] && [[ "${STOP_LINE}" -ge "${START_LINE}" ]]; then
        LINES="$(file_get_lines "${FILE_NAME}" "${START_LINE}" "${STOP_LINE}")"
        [[ -z "${LINES}" ]] && return 1

        LINES="$(string_expand "${LINES}")"
        [[ -z "${LINES}" ]] && return 1

        printf '%s' "${LINES}"
        return $?
    fi
}

# @description  Output text from text blob in file specified by provided blob name
#
# @arg  $BLOB_NAME string - Name of the blob of text to output
# @arg  $FILE_NAME string - File to clip lines from
#
# @exitcode  0  Text blob found
# @exitcode  1  Text blob not found
#
# @stdout  Specified text blob from file expanded 
grab_text_blob() {
    local FILE_NAME="$1"
    local BLOB_NAME="$2"
    local LINES

    LINES="$(file_expand_lines "${FILE_NAME}" "^read -r TEXT_BLOB <<${BLOB_NAME}$" "^${BLOB_NAME}$")"
    [[ -z "${LINES}" ]] && return 1

    printf '%s' "${LINES}"
    return $?
}

# @description  Return if function exists
#
# @arg  $FUNCTION_NAME string - Name of function to check for
#
# @exitcode  0  Function exists
# @exitcode  1  Function does not exist
function_exists() {
    local FUNCTION_NAME="$1"

    type "${FUNCTION_NAME}" > /dev/null 2>&1
    return $?
}


UTIL_ARRAY_SEPARATOR="$(printf '\n\t\v')"
UTIL_PARAM_POSITIONAL=""

# @description  Process call parameters
#
# @arg  $PROCESS_ARG_FN string - Name of argument process function
# @arg  $PROCESS_OPT_FN string - Name of option process function
#
# @exitcode  0  Processing successful
# @exitcode  1  Provided arguments processing function does not exist
# @exitcode  2  Provided options processing function does not exist
# @exitcode  ?  Processing options function return code
process_parameters() {
    local PROCESS_ARG_FN="$1"
    local PROCESS_OPT_FN="$2"
    local SHIFT_COUNT=0

    [[ "$#" -gt 0 ]] && shift
    [[ "$#" -gt 0 ]] && shift

    if ! function_exists "${PROCESS_ARG_FN}"; then
        return 1
    elif ! function_exists "${PROCESS_OPT_FN}"; then
        return 2
    fi

    while [[ "$#" -gt 0 ]]; do
        ${PROCESS_ARG_FN} "${@}"
        SHIFT_COUNT=$?

        if [[ "${SHIFT_COUNT}" -gt 0 ]]; then
            shift "${SHIFT_COUNT}"
        fi
    done

    export OLD_IFS="${IFS}"
    export IFS="${UTIL_ARRAY_SEPARATOR}"

    # Double quoting converts multiple arguments into a single one
    # shellcheck disable=SC2086
    set -- ${UTIL_PARAM_POSITIONAL} # restore positional parameters

    export UTIL_PARAM_POSITIONAL=""
    export IFS="${OLD_IFS}"

    ${PROCESS_OPT_FN} "${@}"
    return $?
}
