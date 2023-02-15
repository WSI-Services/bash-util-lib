# ANSI

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [> Next: File](../file/README.md) ]**


This component module library is named [`bash-util-lib.ansi.sh`](../../src/bash-util-lib.ansi.sh).

- [ANSI](#ansi)
  - [Constants](#constants)
  - [Environment Variables](#environment-variables)
  - [**`es`**](#es)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Out](#standard-out)
  - [**`es_color`**](#es_color)
    - [Arguments](#arguments-1)
    - [Exit Codes](#exit-codes-1)
    - [Standard Out](#standard-out-1)
  - [**`es_color_rgb`**](#es_color_rgb)
    - [Arguments](#arguments-2)
    - [Exit Codes](#exit-codes-2)
    - [Standard Out](#standard-out-2)
  - [**`es_color_hex`**](#es_color_hex)
    - [Arguments](#arguments-3)
    - [Exit Codes](#exit-codes-3)
    - [Standard Out](#standard-out-3)
  - [**`es_attrib`**](#es_attrib)
    - [Arguments](#arguments-4)
    - [Exit Codes](#exit-codes-4)
    - [Standard Out](#standard-out-4)
  - [**`es_erase`**](#es_erase)
    - [Arguments](#arguments-5)
    - [Exit Codes](#exit-codes-5)
    - [Standard Out](#standard-out-5)
  - [**`es_cursor`**](#es_cursor)
    - [Arguments](#arguments-6)
    - [Exit Codes](#exit-codes-6)
    - [Standard Out](#standard-out-6)
  - [**`nc`**](#nc)
    - [Arguments](#arguments-7)
    - [Exit Codes](#exit-codes-7)
    - [Standard Out](#standard-out-7)
  - [**`nc_color`**](#nc_color)
    - [Arguments](#arguments-8)
    - [Exit Codes](#exit-codes-8)
    - [Standard Out](#standard-out-8)
  - [**`nc_cursor`**](#nc_cursor)
    - [Arguments](#arguments-11)
    - [Exit Codes](#exit-codes-11)
    - [Standard Out](#standard-out-11)

---


## Constants

ANSI has a few read-only environment variables defined in their own component module library.

[**READ MORE ...**](./const/README.md)

---


## Environment Variables

| Variable                 | Default         | Description                                                                         |
| ------------------------ | --------------- | ----------------------------------------------------------------------------------- |
| `ES_USE`                 | `true`          | Value as to whether to use escape sequence commands  (used with any `ES*` function) |
| `NC_USE`                 | `true`          | Value as to whether to use ncurses commands  (used with any `NC*` function)         |
| `CMD_TPUT`               | `$(which tput)` | Path to `tput` command utility (used with any `NC*` function)                       |

---


## **`es`**

Output escape sequence with provided control code if **`ES_USE`** environment variable is true

### Arguments

| Name            | Type     | Description                         |
| --------------- | :------: | ----------------------------------- |
| `CONTROL_CODE`  | _string_ | Argument to pass to escape sequence |

### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned on and output sequence |
| `1`  | Command control code turned off or failed          |

### Standard Out

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

---


## **`es_color`**

Output escape sequence with provided color code for foreground or background

### Arguments

| Name    | Type      | Description                                                                                                      |
| ------- | :-------: | ---------------------------------------------------------------------------------------------------------------- |
| `COLOR` | _integer_ | Escape sequence color integer (0 - 255)                                                                          |
| `FG_BG` | _string_  | [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned on and output sequence |
| `1`  | Command control code turned off or failed          |

### Standard Out

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

## **`es_color_rgb`**

Output escape sequence with provided red, green, blue color code for foreground or background

### Arguments

| Name    | Type      | Description                                                                                                      |
| ------- | :-------: | ---------------------------------------------------------------------------------------------------------------- |
| `R`     | _integer_ | Escape sequence red color integer (0 - 255)                                                                      |
| `G`     | _integer_ | Escape sequence green color integer (0 - 255)                                                                    |
| `B`     | _integer_ | Escape sequence blue color integer (0 - 255)                                                                     |
| `FG_BG` | _string_  | [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned on and output sequence |
| `1`  | Command control code turned off or failed          |

### Standard Out

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


## **`es_color_hex`**

Output escape sequence with provided HEX color code for foreground or background

### Arguments

| Name    | Type     | Description                                                                                                      |
| ------- | :------: | ---------------------------------------------------------------------------------------------------------------- |
| `HEX`   | _string_ | Escape sequence color in HEX [RRGGBB] (00 - FF)                                                                  |
| `FG_BG` | _string_ | [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned on and output sequence |
| `1`  | Command control code turned off or failed          |

### Standard Out

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


## **`es_attrib`**

Output escape sequence with provided text attribute control code

### Arguments

| Name           | Type     | Description                                            |
| -------------- | :------: | ------------------------------------------------------ |
| `CONTROL_CODE` | _string_ | [OPTIONAL] Escape sequence text attribute control code |

| Code       | Description                                |
| ---------- | ------------------------------------------ |
| strike     | Strike-through text                        |
| hidden     | Hidden text                                |
| swap       | Swap foreground and background colors      |
| blink      | Slow blink                                 |
| underline  | Underline text                             |
| italic     | Italic text                                |
| fait       | Faint text                                 |
| bold       | Bold text                                  |
| reset      | Reset text formatting and colors [DEFAULT] |

### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned on and output sequence |
| `1`  | Command control code turned off or failed          |

### Standard Out

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


## **`es_erase`**

Output escape sequence with provided erase control code

### Arguments

| Name           | Type     | Description                                   |
| -------------- | :------: | --------------------------------------------- |
| `CONTROL_CODE` | _string_ | [OPTIONAL] Escape sequence erase control code |

| Code   | Description                                             |
| ------ | ------------------------------------------------------- |
| eol    | Erase from cursor position to end of line               |
| sol    | Erase from cursor position to start of line             |
| cur    | Erase the entire current line                           |
| bottom | Erase from the current line to the bottom of the screen |
| top    | Erase from the current line to the top of the screen    |
| clear  | Clear the screen [DEFAULT]                              |

### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned on and output sequence |
| `1`  | Command control code turned off or failed          |

### Standard Out

Specified escape sequence erase control code output

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


## **`es_cursor`**

Output escape sequence with provided cursor control code

### Arguments

| Name           | Type      | Description                                    |
| -------------- | :-------: | ---------------------------------------------- |
| `CONTROL_CODE` | _string_  | [OPTIONAL] Escape sequence cursor control code |
| `VAL1`         | _integer_ | [OPTIONAL] First value for CONTROL_CODE        |
| `VAL2`         | _integer_ | [OPTIONAL] Second value for CONTROL_CODE       |

| Code       | Description                                          |
| ---------- | ---------------------------------------------------- |
| abs        | Move cursor to absolute position line _N_ column _N_ |
| up         | Move cursor up _N_ lines                             |
| down       | Move cursor down _N_ lines                           |
| right      | Move cursor right _N_ columns                        |
| left       | Move cursor left _N_ columns                         |
| save       | Save cursor position                                 |
| restore    | Restore cursor position                              |
| home       | Move cursor to home position (0, 0) [DEFAULT]        |

### Exit Codes

| Code | Description                                        |
| ---- | -------------------------------------------------- |
| `0`  | Command control code turned on and output sequence |
| `1`  | Command control code turned off or failed          |

### Standard Out

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


## **`nc`**

Call ncurses `tput` command with provided arguments if command exists (**`CMD_TPUT`**) and **`NC_USE`** environment variable is true

### Arguments

| Name | Type    | Description                                 |
| ---- | :-----: | ------------------------------------------- |
| `@`  | _array_ | Arguments to pass to ncurses command `tput` |

### Exit Codes

| Code | Description                                   |
| ---- | --------------------------------------------- |
| `0`  | Command `tput` exists                         |
| `1`  | Command `tput` turned off, missing, or failed |

### Standard Out

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

---


## **`nc_color`**

Output ncurses color code for foreground or background

### Arguments

| Name    | Type      | Description                                                                                                      |
| ------- | :-------: | ---------------------------------------------------------------------------------------------------------------- |
| `COLOR` | _integer_ | ncurses color integer (0 - 255)                                                                                  |
| `FG_BG` | _string_  | [OPTIONAL] Background color if starts with 'b' or foreground if starts with 'f', not specified, or anything else |

### Exit Codes

| Code | Description                                   |
| ---- | --------------------------------------------- |
| `0`  | Command `tput` exists                         |
| `1`  | Command `tput` turned off, missing, or failed |

### Standard Out

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


## **`nc_cursor`**

Output ncurses sequence with provided cursor control code

### Arguments

| Name           | Type      | Description                                    |
| -------------- | :-------: | ---------------------------------------------- |
| `CONTROL_CODE` | _string_  | [OPTIONAL] ncurses sequence erase control code |
| `VAL1`         | _integer_ | [OPTIONAL] First value for CONTROL_CODE        |
| `VAL2`         | _integer_ | [OPTIONAL] Second value for CONTROL_CODE       |

| Code          | Description                                          |
| ------------- | ---------------------------------------------------- |
| save          | Save cursor position                                 |
| restore       | Restore cursor position                              |
| invisible     | Make cursor invisible                                |
| invisible-off | Make cursor visible                                  |
| up            | Move cursor up 1 line                                |
| down          | Move cursor down 1 line                              |
| left          | Move cursor left _N_ columns                         |
| right         | Move cursor right _N_ columns                        |
| abs           | Move cursor to absolute position line _N_ column _N_ |
| home          | Move cursor to home position (0, 0) [DEFAULT]        |

### Exit Codes

| Code | Description                                   |
| ---- | --------------------------------------------- |
| `0`  | Command `tput` exists                         |
| `1`  | Command `tput` turned off, missing, or failed |

### Standard Out

Specified ncurses sequence cursor control code output

> Example:
>
> ```bash
> printf "Message: %b\n" "Output$(nc_cursor left 6) Message"
> ```
>
> Output:
>
> ```bash
> Message:  Message
> ```
