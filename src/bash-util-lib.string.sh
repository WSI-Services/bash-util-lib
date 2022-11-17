#!/usr/bin/env bash

# @file  Bash-Util-Lib (String)
# @brief Bash Utility Library (String)

if ! [[ "${BASH_UTIL_LIB_MODULES}" =~ (^|:)STRING(:|$) ]]; then
    BASH_UTIL_LIB_VERSION="0.1.0-dev"
    BASH_UTIL_LIB_MODULES="STRING:${BASH_UTIL_LIB_MODULES}"


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
fi
