#!/usr/bin/env bash

# @file  Bash-Util-Lib (String)
# @brief Bash Utility Library (String)

# shellcheck disable=SC2034 # foo appears unused. Verify it or export it.


if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)STRING(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_DATE="2022-11-09 17:04:48"
    BASH_UTIL_LIB_MODULES="STRING:${BASH_UTIL_LIB_MODULES}"


    # @description  Output provided input processed to expand variables
    #
    # @arg  INPUT string - Text to evaluate for expansion
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

    # @description  String to lowercase
    #
    # @arg  STRING string - String to convert to lowercase
    #
    # @stdout  Provided string to lowercase
    string_lower() {
        local STRING="$1"

        echo "${STRING}" | tr '[:upper:]' '[:lower:]'
    }

    # @description  String to uppercase
    #
    # @arg  STRING string - String to convert to uppercase
    #
    # @stdout  Provided string to uppercase
    string_upper() {
        local STRING="$1"

        echo "${STRING}" | tr '[:lower:]' '[:upper:]'
    }

    # @description  Repeat provided string specified times
    #
    # @arg  COUNT  integer - Number of times to repeat provided string
    # @arg  STRING string  - [OPTIONAL] String to repeat specified times, default: ' '
    #
    # @stdout  Provided string repeated specified times
    string_repeat() {
        local COUNT="$1"
        local STRING="$2"

        [[ $# -eq 1 ]] && STRING=" "

        if [[ "${COUNT}" -gt 0 ]]; then
            printf "%${COUNT}s" |sed "s/ /${STRING}/g"        
        fi
    }

    # Preface each provided line with specified text 
    #
    # @arg  PREFACE string - Characters to prepend to each provided line
    # @arg  LINES   string - Lines of content to prepend specified text to
    #
    # @stdout  Provided lines of content with specified characters prepended
    preface_lines() {
        local PREFACE="$1"
        local LINES="$2"

        printf '%b' "${LINES}" | awk -v pre="${PREFACE}" '{ print pre $0 }'
        return $?
    }
fi
