# Bash-Util-Lib - Bash Utility Library

A library of bash utility functions (from output colors to parameter processing) for use in small projects.


## Development

There is a provided development environment for working on making _changes_, _improvements_, or _updates_ to this project.  [**READ MORE ...**](./DEVELOPMENT.md)


## Install

The library can be installed using the following methods.


### GIT Submodules

If the library is being used inside of a GIT project, then GIT submodules can be utilized.  The following commands should be executed from within the root directory of your GIT project.

- To **download** the `master` branch of the library into the `./deps/bash-util-lib` directory:

    ```bash
    git submodule add -b master https://github.com/WSI-Services/bash-util-lib.git deps/bash-util-lib
    ```

    > **NOTE:** The library branch `master` and path `./deps/bash-util-lib` may be changed to satisfy your projects requirements.  To lock in a specific library version, a library *tagged* release version may be used in lue of the branch name.

- To **change** the **branch** used of the library:

    ```bash
    git submodule set-branch --branch v0.1.1 deps/bash-util-lib
    ```

- To **update** changes to the library:

    ```bash
    git submodule update --rebase --remote
    ```

    Once the submodule is added or updated, make sure to commit changes to your repository.

    ```bash
    git add .gitmodules deps/bash-util-lib
    git commit -m 'Added/updated bash-util-lib submodule'
    ```


### GIT Clone

If you'd rather not use GIT submodules, GIT clone may be used to download the library to the desired location.  The following commands should be executed from within the root directory of your GIT project.

- To **download** the `master` branch of the library into the `./deps/bash-util-lib` directory:

    ```bash
    git clone -b master https://github.com/WSI-Services/bash-util-lib.git deps/bash-util-lib
    ```

    > **NOTE:** The library branch `master` and path `./deps/bash-util-lib` may be changed to satisfy your projects requirements.  To lock in a specific library version, a library *tagged* release version may be used in lue of the branch name.

- To **change** the **branch** used of the library:

    ```bash
    cd deps/bash-util-lib
    git checkout v0.1.1
    ```

- To **update** changes to the library:

    ```bash
    cd deps/bash-util-lib
    git pull
    ```


### Direct Download

If GIT isn't installed, you may download an archive of the library.  The following commands should be executed from within the root directory of your project.

- To **download** the `master` branch archive of the library into the project root directory:

    ```bash
    wget https://github.com/WSI-Services/bash-util-lib/archive/master.zip
    ```

    > **NOTE:** The library branch `master` may be changed to satisfy your projects requirements.  To lock in a specific library version, a library *tagged* release version may be used in lue of the branch name.

- To **extract** the library archive into the `./deps` directory:

    ```bash
    unzip -q master.zip -d deps
    rm master.zip
    mv deps/bash-util-lib-master deps/bash-util-lib
    ```

- To **update** changes to the library:

    ```bash
    rm -Rf deps/bash-util-lib
    ```

    Perform the ***download*** process with the correct branch and the ***extract*** process to replace the previous library.


### Bash Package

If you have the Bash Package Manager (ie: *[bpkg](http://www.bpkg.sh/)*) you can download the associated `wsi-services/bash-util-lib` package:

```bash
bpkg install wsi-services/bash-util-lib
```


## Usage

Bash utility functions can be used by sourcing the library files in your script.  To access the functions within the library, you should import the main bash library as follows.

```bash
source "deps/bash-util-lib/src/bash-util-lib.ansi.sh"
source "deps/bash-util-lib/src/bash-util-lib.file.sh"
source "deps/bash-util-lib/src/bash-util-lib.script.sh"
source "deps/bash-util-lib/src/bash-util-lib.string.sh"
```


## Library Functions

This bash utility library provides functions to simplify writing and running bash scripts.  This section lists the available files, the functions provided, and the usage of them.

---


### ANSI

---


#### **`es`**

Output escape sequence with provided control code if **`ES_USE`** environment variable is true

##### Arguments

| Name            | Type     | Description                         |
| --------------- | :------: | ----------------------------------- |
| `CONTROL_CODE`  | _string_ | Argument to pass to escape sequence |

##### Exit Codes

| Code | Description                          |
| ---- | ------------------------------------ |
| `0`  | Command control code output sequence |
| `1`  | Command control code failed          |

##### Standard Out

Specified escape sequence control code

> Example:
>
> ```bash
> printf "Message: $(es 1m)%s$(es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

##### Environment Variables

| Variable       | Default         | Description                                         |
| -------------- | --------------- | --------------------------------------------------- |
| `ES_USE`       | `true`          | Value as to whether to use escape sequence commands |

---


#### **`es_color`**

Output escape sequence with provided color code for foreground or background

##### Arguments

| Name    | Type     | Description                                                                                           |
| ------- | :------: | ----------------------------------------------------------------------------------------------------- |
| `COLOR` | _string_ | escape sequence color integer                                                                         |
| `FG_BG` | _string_ | Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

##### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned off or failed          |
| `1`  | Command control code turned on and output sequence |

##### Standard Out

Specified escape sequence color code output

> Example:
>
> ```bash
> printf "Message: $(es_color 31)%s$(es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---

#### **`es_color_rgb`**

Output escape sequence with provided red, green, blue color code for foreground or background

##### Arguments

| Name    | Type      | Description                                                                                           |
| ------- | :-------: | ----------------------------------------------------------------------------------------------------- |
| `R`     | _integer_ | Red color integer                                                                                     |
| `G`     | _integer_ | Green color integer                                                                                   |
| `B`     | _integer_ | Blue color integer                                                                                    |
| `FG_BG` | _string_  | Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

##### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned off or failed          |
| `1`  | Command control code turned on and output sequence |

##### Standard Out

Specified escape sequence color code output

> Example:
>
> ```bash
> printf "Message: $(es_color_rgb 255 0 0)%s$(es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


#### **`es_color_hex`**

Output escape sequence with provided HEX color code for foreground or background

##### Arguments

| Name    | Type     | Description                                                                                           |
| ------- | :------: | ----------------------------------------------------------------------------------------------------- |
| `HEX`   | _string_ | escape sequence color in HEX                                                                          |
| `FG_BG` | _string_ | Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

##### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned off or failed          |
| `1`  | Command control code turned on and output sequence |

##### Standard Out

Specified escape sequence color code output

> Example:
>
> ```bash
> printf "Message: $(es_color_hex ff0000)%s$(es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


#### **`es_attrib`**

Output escape sequence with provided text attribute control code

##### Arguments

| Name           | Type     | Description                                 |
| -------------- | :------: | ------------------------------------------- |
| `CONTROL_CODE` | _string_ | escape sequence text attribute control code |

| Code      | Description                           |
| --------- | ------------------------------------- |
| strike    | Strike-through text                   |
| hidden    | Hidden text                           |
| swap      | Swap foreground and background colors |
| blink     | Slow blink                            |
| underline | Underline text                        |
| italic    | Italic text                           |
| fait      | Faint text                            |
| bold      | Bold text                             |
| reset     | Reset text formatting and colors      |

##### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned off or failed          |
| `1`  | Command control code turned on and output sequence |

##### Standard Out

Specified escape sequence text attribute control code output

> Example:
>
> ```bash
> printf "Message: $(es_attrib bold)%s$(es_attrib reset)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


#### **`es_erase`**

Output escape sequence with provided erase control code

##### Arguments

| Name           | Type     | Description                        |
| -------------- | :------: | ---------------------------------- |
| `CONTROL_CODE` | _string_ | escape sequence erase control code |

| Code   | Description                                             |
| ------ | ------------------------------------------------------- |
| eol    | Erase from cursor position to end of line               |
| sol    | Erase from cursor position to start of line             |
| cur    | Erase the entire current line                           |
| bottom | Erase from the current line to the bottom of the screen |
| top    | Erase from the current line to the top of the screen    |
| clear  | Clear the screen                                        |

##### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned off or failed          |
| `1`  | Command control code turned on and output sequence |

##### Standard Out

Specified escape sequence text attribute control code output

> Example:
>
> ```bash
> printf "Message: %b\n" "Output$(es_erase sol) Message"
> ```
>
> Output:
>
> ```bash
>                 Message
> ```

---


#### **`es_cursor`**

Output escape sequence with provided cursor control code

##### Arguments

| Name           | Type      | Description                         |
| -------------- | :-------: | ----------------------------------- |
| `CONTROL_CODE` | _string_  | Escape sequence cursor control code |
| `VAL1`         | _integer_ | Optional value for CONTROL_CODE     |
| `VAL2`         | _integer_ | Optional value for CONTROL_CODE     |

| Code    | Description                                    |
| ------- | ---------------------------------------------- |
| abs     | Move cursor to absolute position (LINE;COLUMN) |
| up      | Move cursor up N lines (NUM)                   |
| down    | Move cursor down N lines (NUM)                 |
| right   | Move cursor right N columns (NUM)              |
| left    | Move cursor left N columns (NUM)               |
| save    | Save cursor position                           |
| restore | Restore cursor position                        |
| home    | Move cursor to home position (0,0)             |

##### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned off or failed          |
| `1`  | Command control code turned on and output sequence |

##### Standard Out

Specified escape sequence cursor control code output

> Example:
>
> ```bash
> printf "Message: %b\n" "Output$(es_cursor left 6) Message"
> ```
>
> Output:
>
> ```bash
> Message:  Message
> ```

---


#### **`nc`**

Call ncurses `tput` command with provided arguments if command exists (**`CMD_TPUT`**) and **`NC_USE`** environment variable is true

##### Arguments

| Name | Type    | Description                                 |
| ---- | :-----: | ------------------------------------------- |
| `@`  | _array_ | Arguments to pass to ncurses command `tput` |

##### Exit Codes

| Code | Description                         |
| ---- | ----------------------------------- |
| `0`  | Command `tput` exists and succeeded |
| `1`  | Command `tput` missing or failed    |

##### Standard Out

Specified ncurses `tput` output

> Example:
>
> ```bash
> printf "Message: $(nc bold)%s$(nc sgr0)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

##### Environment Variables

| Variable       | Default         | Description                                 |
| -------------- | --------------- | ------------------------------------------- |
| `CMD_TPUT`     | `$(which tput)` | Path to `tput` command utility              |
| `NC_USE`       | `true`          | Value as to whether to use ncurses commands |
| `NC_BOLD`      | `$(nc bold)`    | ncurses command for text bold               |
| `NC_UNDERLINE` | `$(nc sgr 0 1)` | ncurses command for text underline          |
| `NC_RESET`     | `$(nc sgr0)`    | ncurses command for text reset              |

---


#### **`nc_color`**

Output ncurses color code for foreground or background

##### Arguments

| Name    | Type     | Description                                                                                           |
| ------- | :------: | ----------------------------------------------------------------------------------------------------- |
| `COLOR` | _string_ | ncurses color in HEX                                                                                  |
| `FG_BG` | _string_ | Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

##### Exit Codes

| Code | Description            |
| ---- | ---------------------- |
| `0`  | Command `tput` exists  |
| `1`  | Command `tput` missing |

##### Standard Out

Specified ncurses `tput` color code output

> Example:
>
> ```bash
> printf "Message: $(nc_color 031)%s$(nc sgr0)" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


#### **`nc_color_from_hex`**

Output ncurses color index integer from HEX

##### Arguments

| Name  | Type     | Description                                 |
| ----- | :------: | ------------------------------------------- |
| `HEX` | _string_ | HEX color code (RRGGBB) without number sign |

##### Exit Codes

| Code | Description            |
| ---- | ---------------------- |
| `0`  | HEX value provided     |
| `1`  | HEX value not provided |

##### Standard Out

Specified ncurses color index integer

> Example:
>
> ```bash
> nc_color_from_hex ff0000
> ```
>
> Output:
>
> ```bash
> 196
> ```

---


#### **`nc_color_hex`**

Output ncurses color code in HEX for foreground or background

##### Arguments

| Name    | Type     | Description                                                                                           |
| ------- | :------: | ----------------------------------------------------------------------------------------------------- |
| `COLOR` | _string_ | ncurses color in HEX                                                                                  |
| `FG_BG` | _string_ | Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

##### Exit Codes

| Code | Description            |
| ---- | ---------------------- |
| `0`  | Command `tput` exists  |
| `1`  | Command `tput` missing |

##### Standard Out

Specified ncurses `tput` color code output

> Example:
>
> ```bash
> printf "Message: $(nc_color_hex ff0000)%s$(nc sgr0)" "Output Message"
> ```
>
> Output:
> ```bash
> Message: Output Message
> ```

##### Environment Variables

| Variable        | Default                    | Description                                       |
| --------------- | -------------------------- | ------------------------------------------------- |
| `NC_BLACK`      | `$(nc_color_hex 000000)`   | ncurses command for text color black foreground   |
| `NC_RED`        | `$(nc_color_hex ff0000)`   | ncurses command for text color red foreground     |
| `NC_GREEN`      | `$(nc_color_hex 00ff00)`   | ncurses command for text color green foreground   |
| `NC_YELLOW`     | `$(nc_color_hex ffff00)`   | ncurses command for text color yellow foreground  |
| `NC_BLUE`       | `$(nc_color_hex 0000ff)`   | ncurses command for text color blue foreground    |
| `NC_MAGENTA`    | `$(nc_color_hex ff00ff)`   | ncurses command for text color magenta foreground |
| `NC_CYAN`       | `$(nc_color_hex 00ffff)`   | ncurses command for text color cyan foreground    |
| `NC_WHITE`      | `$(nc_color_hex ffffff)`   | ncurses command for text color white foreground   |
| `NC_BLACK_BG`   | `$(nc_color_hex 000000 b)` | ncurses command for text color black background   |
| `NC_RED_BG`     | `$(nc_color_hex ff0000 b)` | ncurses command for text color red background     |
| `NC_GREEN_BG`   | `$(nc_color_hex 00ff00 b)` | ncurses command for text color green background   |
| `NC_YELLOW_BG`  | `$(nc_color_hex ffff00 b)` | ncurses command for text color yellow background  |
| `NC_BLUE_BG`    | `$(nc_color_hex 0000ff b)` | ncurses command for text color blue background    |
| `NC_MAGENTA_BG` | `$(nc_color_hex ff00ff b)` | ncurses command for text color magenta background |
| `NC_CYAN_BG`    | `$(nc_color_hex 00ffff b)` | ncurses command for text color cyan background    |
| `NC_WHITE_BG`   | `$(nc_color_hex ffffff b)` | ncurses command for text color white background   |

---


### FILE

---


#### **`file_find_line`**

Output last line number in provided file which matches provided pattern

##### Arguments

| Name         | Type     | Description              |
| ------------ | :------: | ------------------------ |
| `FILE_NAME`  | _string_ | File to scan for pattern |
| `PATTERN`    | _string_ | Pattern to scan file for |

##### Exit Codes

| Code | Description     |
| ---- | --------------- |
| `0`  | Lines found     |
| `1`  | Lines not found |

##### Standard Out

Line number of last matching line pattern

> Example:
>
> ```bash
> file_find_line "/path/to/file.ext" "^#{2}\wSTART:\w${TAG}$"
> ```
>
> Output:
>
> ```bash
> 24
> ```

---


#### **`file_get_lines`**

Output lines of provided file from provided start line till provided stop line

##### Arguments

| Name         | Type      | Description               |
| ------------ | :-------: | ------------------------- |
| `FILE_NAME`  | _string_  | File to clip lines from   |
| `START_LINE` | _integer_ | Line number to begin clip |
| `STOP_LINE`  | _integer_ | Line number to end clip   |

##### Exit Codes

| Code | Description     |
| ---- | --------------- |
| `0`  | Lines found     |
| `1`  | Lines not found |

##### Standard Out

Specified lines from file

> Example:
>
> ```bash
> file_get_lines "/path/to/file.ext" "24" "26"
> ```
>
> Output:
>
> ```bash
> ## START: Test
> function test { :; }
> ## STOP: Test
> ```

---


#### **`file_expand_lines`**

Output text from section in file specified by provided patterns

##### Arguments

| Name            | Type     | Description                         |
| --------------- | :------: | ----------------------------------- |
| `FILE_NAME`     | _string_ | File to clip lines from             |
| `START_PATTERN` | _string_ | Pattern of the start line to output |
| `STOP_PATTERN`  | _string_ | Pattern of the stop line to output  |

##### Exit Codes

| Code | Description              |
| ---- | ------------------------ |
| `0`  | Lines found and expanded |
| `1`  | Lines not found          |

##### Standard Out

Specified lines from file expanded

> Example:
>
> ```bash
> file_expand_lines "/path/to/file.ext" "^#{2}\wSTART:\w${TAG}$" "^#{2}\wSTOP:\w${TAG}$"
> ```
>
> Output:
>
> ```bash
> function test { :; }
> ```

---


#### **`grab_text_blob`**

Output text from text blob in file specified by provided blob name

##### Arguments

| Name        | Type     | Description                        |
| ----------- | :------: | ---------------------------------- |
| `BLOB_NAME` | _string_ | Name of the blob of text to output |
| `FILE_NAME` | _string_ | File to clip lines from            |

##### Exit Codes

| Code | Description         |
| ---- | ------------------- |
| `0`  | Text blob found     |
| `1`  | Text blob not found |

##### Standard Out

Specified text blob from file expanded

> Example:
>
> ```bash
> grab_text_blob "BLOB_TEST" "/path/to/file.ext"
> ```
>
> Output:
>
> ```bash
> Test text blob
> ```

---


### SCRIPT

---


#### **`exit_err`**

Output provided error message, optionally additional message, and exit with provided code

##### Arguments

| Name       | Type      | Description                             |
| ---------- | :-------: | --------------------------------------- |
| `ERR_CODE` | _integer_ | Exit code                               |
| `ERR_MSG`  | _string_  | Message to output                       |
| `ADD_MSG`  | _string_  | [OPTIONAL] Additional message to output |

##### Exit Codes

| Code | Description                  |
| ---- | ---------------------------- |
| `?`  | Provided `ERR_CODE` argument |

##### Standard Error

Provided **ERR_CODE** and **ERR_MSG** using the **EXIT_ERR_MSG_ERROR** format; and optional **UTIL_SCRIPT_CMD** (if set) using the **EXIT_ERR_MSG_COMMAND** format

##### Standard Out

If provided, additional message **ADD_MSG** using the **EXIT_ERR_MSG_ADDITIONAL** format

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

##### Environment Variables

| Variable                  | Default                                                                                            | Description                                                   |
| ------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| `EXIT_ERR_MSG_ERROR`      | `${NC_RED}Error [${NC_BOLD}%i${NC_RESET}${NC_RED}]${NC_RESET}: ${NC_BOLD}${NC_RED}%b${NC_RESET}\n` | Variable to store `printf` style string for error message     |
| `EXIT_ERR_MSG_COMMAND`    | `${NC_RED}Command failed${NC_RESET}: ${NC_BOLD}${NC_WHITE}%b${NC_RESET}\n`                         | Variable to store `printf` style string for command string    |
| `EXIT_ERR_MSG_ADDITIONAL` | `%s\n`                                                                                             | Variable to store `printf` style string for additional string |
| `UTIL_SCRIPT_CMD`         |                                                                                                    | Variable to hold command string                               |

---


#### **`function_exists`**

Returns status of function existing

##### Arguments

| Name            | Type     | Description                       |
| --------------- | :------: | --------------------------------- |
| `FUNCTION_NAME` | _string_ | Name of function to check for     |

##### Exit Codes

| Code | Description             |
| ---- | ----------------------- |
| `0`  | Function exists         |
| `1`  | Function does not exist |

##### Standard Out

> Example:
>
> ```bash
> function_exists "missing_test"
> ```
>
> Exit Code: 1

---


#### **`process_parameters`**

Process call parameters

##### Arguments

| Name             | Type     | Description                       |
| ---------------- | :------: | --------------------------------- |
| `PROCESS_ARG_FN` | _string_ | Name of argument process function |
| `PROCESS_OPT_FN` | _string_ | Name of option process function   |

##### Exit Codes

| Code | Description                                           |
| ---- | ----------------------------------------------------- |
| `0`  | Processing successful                                 |
| `1`  | Provided arguments processing function does not exist |
| `2`  | Provided options processing function does not exist   |
| `?`  | Processing options function return code               |

##### Environment Variables

| Variable                | Default              | Description                                   |
| ----------------------- | -------------------- | --------------------------------------------- |
| `UTIL_ARRAY_SEPARATOR`  | `$(printf '\n\t\v')` | Value to use to separate positional arguments |
| `UTIL_PARAM_POSITIONAL` |                      | Variable to store positional arguments        |

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

---


### STRING

---


#### **`string_expand`**

Output provided input processed to expand variables

##### Arguments

| Name    | Type     | Description                    |
| ------- | :------: | ------------------------------ |
| `INPUT` | _string_ | Text to evaluate for expansion |

##### Exit Codes

| Code | Description     |
| ---- | --------------- |
| `0`  | String expanded |
| `1`  | String missing  |

##### Standard Out

Specified string expanded

> Example:
>
> ```bash
> string_expand "Output: \${STRING}"
> ```
>
> Output:
>
> ```bash
> Output: Test
> ```
