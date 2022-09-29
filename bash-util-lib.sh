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
