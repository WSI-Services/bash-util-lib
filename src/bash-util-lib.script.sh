#!/usr/bin/env bash

# @file  Bash-Util-Lib (Script)
# @brief Bash Utility Library (Script)

# shellcheck disable=SC2034 # foo appears unused. Verify it or export it.
# shellcheck disable=SC2059 # Don't use variables in the printf format string. Use printf "..%s.." "$foo".
# shellcheck disable=SC2154 # var is referenced but not assigned.


if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)SCRIPT(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_DATE="2022-11-09 17:04:48"
    BASH_UTIL_LIB_MODULES="SCRIPT:${BASH_UTIL_LIB_MODULES}"

    source "$(dirname "${BASH_SOURCE[0]}")/bash-util-lib.ansi.const.sh"


    EXIT_ERR_MSG_ERROR="${ANSI_RED}Error [${ANSI_BOLD}%i${ANSI_RESET}${ANSI_RED}]${ANSI_RESET}: ${ANSI_BOLD}${ANSI_RED}%b${ANSI_RESET}\n"
    EXIT_ERR_MSG_COMMAND="${ANSI_RED}Command failed${ANSI_RESET}: ${ANSI_BOLD}${ANSI_WHITE}%b${ANSI_RESET}\n"
    EXIT_ERR_MSG_ADDITIONAL="%s\n"
    UTIL_SCRIPT_CMD=""

    UTIL_ARRAY_SEPARATOR="$(printf '\n\t\v')"
    UTIL_PARAM_POSITIONAL=""


    # @description  Output provided error message, optionally additional message, and exit with provided code
    #
    # @arg  ERR_CODE integer - Exit code
    # @arg  ERR_MSG  string  - Message to output
    # @arg  ADD_MSG  string  - [OPTIONAL] Additional message to output
    #
    # @exitcode  ?  Provided ERR_CODE argument
    #
    # @stderr  Provided **`ERR_CODE`** and **`ERR_MSG`** using the **`EXIT_ERR_MSG_ERROR`** format; and optional **`UTIL_SCRIPT_CMD`** (if set) using the **`EXIT_ERR_MSG_COMMAND`** format
    # @stdout  If provided, additional message **`ADD_MSG`** using the **`EXIT_ERR_MSG_ADDITIONAL`** format
    function script::exitErr() {
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

    # @description  Returns status of function existing
    #
    # @arg  FUNCTION_NAME string - Name of function to check for
    #
    # @exitcode  0  Function exists
    # @exitcode  1  Function does not exist
    function script::functionExists() {
        local FUNCTION_NAME="$1"

        type "${FUNCTION_NAME}" > /dev/null 2>&1
        return $?
    }

    # @description  Process call parameters
    #
    # @arg  PROCESS_ARG_FN string - Name of argument process function
    # @arg  PROCESS_OPT_FN string - Name of option process function
    #
    # @exitcode  0  Processing successful
    # @exitcode  1  Provided arguments processing function does not exist
    # @exitcode  2  Provided options processing function does not exist
    # @exitcode  ?  Processing options function return code
    function script::processParameters() {
        local PROCESS_ARG_FN="$1"
        local PROCESS_OPT_FN="$2"
        local SHIFT_COUNT=0

        [[ "$#" -gt 0 ]] && shift
        [[ "$#" -gt 0 ]] && shift

        if ! script::functionExists "${PROCESS_ARG_FN}"; then
            return 1
        elif ! script::functionExists "${PROCESS_OPT_FN}"; then
            return 2
        fi

        while [[ "$#" -gt 0 ]]; do
            ${PROCESS_ARG_FN} "${@}"
            SHIFT_COUNT=$?

            if [[ "${SHIFT_COUNT}" -gt "$#" ]]; then
                shift "$#"
            elif [[ "${SHIFT_COUNT}" -gt 0 ]]; then
                shift "${SHIFT_COUNT}"
            fi
        done

        export OLD_IFS="${IFS}"
        export IFS="${UTIL_ARRAY_SEPARATOR}"

        # Double quoting converts multiple arguments into a single one
        # shellcheck disable=SC2086 # Double quote to prevent globbing and word splitting.
        set -- ${UTIL_PARAM_POSITIONAL} # restore positional parameters

        export UTIL_PARAM_POSITIONAL=""
        export IFS="${OLD_IFS}"

        ${PROCESS_OPT_FN} "${@}"
        return $?
    }
fi
