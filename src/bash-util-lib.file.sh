#!/usr/bin/env bash

# @file  Bash-Util-Lib (File)
# @brief Bash Utility Library (File)

# shellcheck disable=SC2034 # foo appears unused. Verify it or export it.


if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)FILE(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_MODULES="FILE:${BASH_UTIL_LIB_MODULES}"


    # @description  Output last line number in provided file which matches provided pattern
    #
    # @arg  FILE_NAME string - File to scan for pattern
    # @arg  PATTERN   string - Pattern to scan file for
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
    # @arg  FILE_NAME  string  - File to clip lines from
    # @arg  START_LINE integer - Line number to begin clip
    # @arg  STOP_LINE  integer - Line number to end clip
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

    # @description  Output text from section in file specified by provided patterns
    #
    # @arg  FILE_NAME     string - File to clip lines from
    # @arg  START_PATTERN string - Pattern of the start line to output
    # @arg  STOP_PATTERN  string - Pattern of the stop line to output
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
    # @arg  BLOB_NAME string - Name of the blob of text to output
    # @arg  FILE_NAME string - File to clip lines from
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
fi
