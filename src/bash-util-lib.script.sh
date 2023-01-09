#!/usr/bin/env bash

# @file  Bash-Util-Lib (Script)
# @brief Bash Utility Library (Script)

if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)SCRIPT(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_MODULES="SCRIPT:${BASH_UTIL_LIB_MODULES}"


    EXIT_ERR_MSG_ERROR="${NC_RED}Error [${NC_BOLD}%i${NC_RESET}${NC_RED}]${NC_RESET}: ${NC_BOLD}${NC_RED}%b${NC_RESET}\n"
    EXIT_ERR_MSG_COMMAND="${NC_RED}Command failed${NC_RESET}: ${NC_BOLD}${NC_WHITE}%b${NC_RESET}\n"
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

    # @description  Returns status of function existing
    #
    # @arg  FUNCTION_NAME string - Name of function to check for
    #
    # @exitcode  0  Function exists
    # @exitcode  1  Function does not exist
    function_exists() {
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
fi
