# Script

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [< Previous: File](../file/README.md) &nbsp;&mdash;&nbsp; [> Next: String](../string/README.md) ]**

- [Script](#script)
  - [Environment Variables](#environment-variables)
  - [**`exit_err`**](#exit_err)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Error](#standard-error)
    - [Standard Out](#standard-out)
  - [**`function_exists`**](#function_exists)
    - [Arguments](#arguments-1)
    - [Exit Codes](#exit-codes-1)
  - [**`process_parameters`**](#process_parameters)
    - [Arguments](#arguments-2)
    - [Exit Codes](#exit-codes-2)

---


## Environment Variables

| Variable                  | Default                                                                                            | Description                                                   |
| ------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| `EXIT_ERR_MSG_ERROR`      | `${NC_RED}Error [${NC_BOLD}%i${NC_RESET}${NC_RED}]${NC_RESET}: ${NC_BOLD}${NC_RED}%b${NC_RESET}\n` | Variable to store `printf` style string for error message     |
| `EXIT_ERR_MSG_COMMAND`    | `${NC_RED}Command failed${NC_RESET}: ${NC_BOLD}${NC_WHITE}%b${NC_RESET}\n`                         | Variable to store `printf` style string for command string    |
| `EXIT_ERR_MSG_ADDITIONAL` | `%s\n`                                                                                             | Variable to store `printf` style string for additional string |
| `UTIL_SCRIPT_CMD`         |                                                                                                    | Variable to hold command string                               |
| `UTIL_ARRAY_SEPARATOR`    | `$(printf '\n\t\v')`                                                                               | Value to use to separate positional arguments                 |
| `UTIL_PARAM_POSITIONAL`   |                                                                                                    | Variable to store positional arguments                        |

---


## **`exit_err`**

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
> exit_err 12 "Missing value" "Extra data here"
> ```
>
> Output:
>
> ```bash
> Error [12]: Missing value
> Extra data here
> ```

---


## **`function_exists`**

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
> function_exists "missing_test"
> ```
>
> Exit Code: 1

---


## **`process_parameters`**

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
> process_parameters "processArgs" "dispatchCommand" "${@}"
> ```
