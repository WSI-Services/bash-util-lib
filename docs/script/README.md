# Script

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [< Previous: File](../file/README.md) &nbsp;&mdash;&nbsp; [> Next: String](../string/README.md) ]**


This component module library is named [`bash-util-lib.script.sh`](../../src/bash-util-lib.script.sh).

- [Script](#script)
  - [Environment Variables](#environment-variables)
  - [**`script::exitErr`**](#scriptexiterr)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Error](#standard-error)
    - [Standard Out](#standard-out)
  - [**`script::functionExists`**](#scriptfunctionexists)
    - [Arguments](#arguments-1)
    - [Exit Codes](#exit-codes-1)
  - [**`script::processParameters`**](#scriptprocessparameters)
    - [Arguments](#arguments-2)
    - [Exit Codes](#exit-codes-2)

---


## Environment Variables

| Variable                  | Default                                                                                                            | Description                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------- |
| `EXIT_ERR_MSG_ERROR`      | `${ANSI_RED}Error [${ANSI_BOLD}%i${ANSI_RESET}${ANSI_RED}]${ANSI_RESET}: ${ANSI_BOLD}${ANSI_RED}%b${ANSI_RESET}\n` | Variable to store `printf` style string for error message     |
| `EXIT_ERR_MSG_COMMAND`    | `${ANSI_RED}Command failed${ANSI_RESET}: ${ANSI_BOLD}${ANSI_WHITE}%b${ANSI_RESET}\n`                               | Variable to store `printf` style string for command string    |
| `EXIT_ERR_MSG_ADDITIONAL` | `%s\n`                                                                                                             | Variable to store `printf` style string for additional string |
| `UTIL_SCRIPT_CMD`         |                                                                                                                    | Variable to hold command string                               |
| `UTIL_ARRAY_SEPARATOR`    | `$(printf '\n\t\v')`                                                                                               | Value to use to separate positional arguments                 |
| `UTIL_PARAM_POSITIONAL`   |                                                                                                                    | Variable to store positional arguments                        |

---


## **`script::exitErr`**

Output provided error message, optionally additional message, and exit with provided code

### Arguments

| Name       | Type      | Description                             |
| ---------- | :-------: | --------------------------------------- |
| `ERR_CODE` | _integer_ | Exit code                               |
| `ERR_MSG`  | _string_  | Message to output                       |
| `ADD_MSG`  | _string_  | [OPTIONAL] Additional message to output |

### Exit Codes

| Code | Description                  |
| ---- | ---------------------------- |
| `?`  | Provided `ERR_CODE` argument |

### Standard Error

Provided **`ERR_CODE`** and **`ERR_MSG`** using the **`EXIT_ERR_MSG_ERROR`** format; and optional **`UTIL_SCRIPT_CMD`** (if set) using the **`EXIT_ERR_MSG_COMMAND`** format

### Standard Out

If provided, additional message **`ADD_MSG`** using the **`EXIT_ERR_MSG_ADDITIONAL`** format

> Example:
>
> ```bash
> script::exitErr 12 "Missing value" "Extra data here"
> ```
>
> Output:
>
> ```bash
> Error [12]: Missing value
> Extra data here
> ```

---


## **`script::functionExists`**

Returns status of function existing

### Arguments

| Name            | Type     | Description                       |
| --------------- | :------: | --------------------------------- |
| `FUNCTION_NAME` | _string_ | Name of function to check for     |

### Exit Codes

| Code | Description             |
| ---- | ----------------------- |
| `0`  | Function exists         |
| `1`  | Function does not exist |

> Example:
>
> ```bash
> script::functionExists "missing_test"
> ```
>
> Exit Code: 1

---


## **`script::processParameters`**

Process call parameters

### Arguments

| Name             | Type     | Description                       |
| ---------------- | :------: | --------------------------------- |
| `PROCESS_ARG_FN` | _string_ | Name of argument process function |
| `PROCESS_OPT_FN` | _string_ | Name of option process function   |

### Exit Codes

| Code | Description                                           |
| ---- | ----------------------------------------------------- |
| `0`  | Processing successful                                 |
| `1`  | Provided arguments processing function does not exist |
| `2`  | Provided options processing function does not exist   |
| `?`  | Processing options function return code               |

> Example:
>
> ```bash
> processArgs() {
>     ARG1="$1"
>     POS_ARG=""
>     SHIFT_COUNT=0
>
>     if [[ "${PASS_ARGS}" -gt 0 ]]; then
>         POS_ARG="${ARG1}"
>         SHIFT_COUNT=$((SHIFT_COUNT+1))
>     else
>         case "${ARG1}" in
>             -a=*|--add=*) # display details for equals-separated option value
>                 export ARGS_DETAILS="${ARGS_DETAILS}${ARGS_DETAILS:+ }${ARG1#*=}"
>                 SHIFT_COUNT=$((SHIFT_COUNT+1))
>                 ;;
>             -a|--add)     # display details for space-separated option value
>                 export ARGS_DETAILS="${ARGS_DETAILS}${ARGS_DETAILS:+ }$2"
>                 SHIFT_COUNT=$((SHIFT_COUNT+2))
>                 ;;
>             -l|--list)    # list all
>                 export LISTING=1
>                 SHIFT_COUNT=$((SHIFT_COUNT+1))
>                 ;;
>             --)           # pass following arguments
>                 export PASS_ARGS=1
>                 SHIFT_COUNT=$((SHIFT_COUNT+1))
>                 ;;
>             *)            # unknown argument
>                 POS_ARG="${ARG1}"
>                 SHIFT_COUNT=$((SHIFT_COUNT+1))
>                 ;;
>         esac
>     fi
>
>     if [[ -n "$POS_ARG" ]]; then
>         # save argument in an array for later
>         export UTIL_PARAM_POSITIONAL="${UTIL_PARAM_POSITIONAL}${UTIL_PARAM_POSITIONAL:+${UTIL_ARRAY_SEPARATOR}}${POS_ARG}"
>     fi
>
>     return "${SHIFT_COUNT}"
> }
>
> dispatchCommand() {
>     COMMAND="$1"
>     [[ $# -gt 0 ]] && shift
>
>     case "${COMMAND}" in
>         commands) command_commands "${@}" ;;
>         version)  command_version  "${@}" ;;
>         help|*)   command_help     "${@}" ;;
>     esac
> }
>
> script::processParameters "processArgs" "dispatchCommand" "${@}"
> ```
