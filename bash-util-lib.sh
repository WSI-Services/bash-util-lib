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
