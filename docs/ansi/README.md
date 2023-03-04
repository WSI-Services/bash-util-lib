# ANSI

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [> Next: File](../file/README.md) ]**


This component module library is named [`bash-util-lib.ansi.sh`](../../src/bash-util-lib.ansi.sh).

- [ANSI](#ansi)
  - [Constants](#constants)
  - [Environment Variables](#environment-variables)
  - [**`ansi::es`**](#ansies)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Out](#standard-out)
  - [**`ansi::es::color`**](#ansiescolor)
    - [Arguments](#arguments-1)
    - [Exit Codes](#exit-codes-1)
    - [Standard Out](#standard-out-1)
  - [**`ansi::es::colorRgb`**](#ansiescolorrgb)
    - [Arguments](#arguments-2)
    - [Exit Codes](#exit-codes-2)
    - [Standard Out](#standard-out-2)
  - [**`ansi::es::colorHex`**](#ansiescolorhex)
    - [Arguments](#arguments-3)
    - [Exit Codes](#exit-codes-3)
    - [Standard Out](#standard-out-3)
  - [**`ansi::es::attrib`**](#ansiesattrib)
    - [Arguments](#arguments-4)
    - [Exit Codes](#exit-codes-4)
    - [Standard Out](#standard-out-4)
  - [**`ansi::es::erase`**](#ansieserase)
    - [Arguments](#arguments-5)
    - [Exit Codes](#exit-codes-5)
    - [Standard Out](#standard-out-5)
  - [**`ansi::es::cursor`**](#ansiescursor)
    - [Arguments](#arguments-6)
    - [Exit Codes](#exit-codes-6)
    - [Standard Out](#standard-out-6)
  - [**`ansi::nc`**](#ansinc)
    - [Arguments](#arguments-7)
    - [Exit Codes](#exit-codes-7)
    - [Standard Out](#standard-out-7)
  - [**`ansi::nc::color`**](#ansinccolor)
    - [Arguments](#arguments-8)
    - [Exit Codes](#exit-codes-8)
    - [Standard Out](#standard-out-8)
  - [**`ansi::nc::attrib`**](#ansincattrib)
    - [Arguments](#arguments-9)
    - [Exit Codes](#exit-codes-9)
    - [Standard Out](#standard-out-9)
  - [**`ansi::nc::erase`**](#ansincerase)
    - [Arguments](#arguments-10)
    - [Exit Codes](#exit-codes-10)
    - [Standard Out](#standard-out-10)
  - [**`ansi::nc::cursor`**](#ansinccursor)
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


## **`ansi::es`**

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
> printf "Message: $(ansi::es 1m)%s$(ansi::es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


## **`ansi::es::color`**

Output escape sequence with provided color code for foreground, background, or underline

### Arguments

| Name    | Type      | Description                             |
| ------- | :-------: | --------------------------------------- |
| `COLOR` | _integer_ | Escape sequence color integer (0 - 255) |
| `ROLE`  | _string_  | [OPTIONAL] Role of color to change      |

| Role | Description                |
| ---- | -------------------------- |
| `f`  | Foreground color [DEFAULT] |
| `b`  | Background color           |
| `u`  | Underline color            |

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
> printf "Message: $(ansi::es::color 31)%s$(ansi::es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---

## **`ansi::es::colorRgb`**

Output escape sequence with provided red, green, blue color code for foreground, background, or underline

### Arguments

| Name   | Type      | Description                                   |
| ------ | :-------: | --------------------------------------------- |
| `R`    | _integer_ | Escape sequence red color integer (0 - 255)   |
| `G`    | _integer_ | Escape sequence green color integer (0 - 255) |
| `B`    | _integer_ | Escape sequence blue color integer (0 - 255)  |
| `ROLE` | _string_  | [OPTIONAL] Role of color to change            |

| Role | Description                |
| ---- | -------------------------- |
| `f`  | Foreground color [DEFAULT] |
| `b`  | Background color           |
| `u`  | Underline color            |

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
> printf "Message: $(ansi::es::colorRgb 255 0 0)%s$(ansi::es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


## **`ansi::es::colorHex`**

Output escape sequence with provided HEX color code for foreground, background, or underline

### Arguments

| Name   | Type     | Description                                     |
| ------ | :------: | ----------------------------------------------- |
| `HEX`  | _string_ | Escape sequence color in HEX [RRGGBB] (00 - FF) |
| `ROLE` | _string_ | [OPTIONAL] Role of color to change              |

| Role | Description                |
| ---- | -------------------------- |
| `f`  | Foreground color [DEFAULT] |
| `b`  | Background color           |
| `u`  | Underline color            |

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
> printf "Message: $(ansi::es::colorHex ff0000)%s$(ansi::es 0m)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


## **`ansi::es::attrib`**

Output escape sequence with provided text attribute control code

### Arguments

| Name           | Type     | Description                                            |
| -------------- | :------: | ------------------------------------------------------ |
| `CONTROL_CODE` | _string_ | [OPTIONAL] Escape sequence text attribute control code |

| Code            | Description                                |
| --------------- | ------------------------------------------ |
| underline-off   | Underline color off                        |
| background-off  | Background color off                       |
| foreground-off  | Foreground color off                       |
| overline-reset  | Overline text                              |
| strike-reset    | Strike-through text                        |
| hidden-reset    | Hidden text                                |
| swap-reset      | Swap foreground and background colors      |
| blink-reset     | Slow blink                                 |
| underline-reset | Underline text                             |
| italic-reset    | Italic text                                |
| faint-reset     | Faint text                                 |
| bold-reset      | Bold text                                  |
| overline        | Overline text                              |
| strike          | Strike-through text                        |
| hidden          | Hidden text                                |
| swap            | Swap foreground and background colors      |
| fast-blink      | Fast blink                                 |
| blink           | Slow blink                                 |
| underline       | Underline text                             |
| italic          | Italic text                                |
| fait            | Faint text                                 |
| bold            | Bold text                                  |
| reset           | Reset text formatting and colors [DEFAULT] |

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
> printf "Message: $(ansi::es::attrib bold)%s$(ansi::es::attrib reset)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


## **`ansi::es::erase`**

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
> printf "Message: %b\n" "Output$(ansi::es::erase sol) Message"
> ```
>
> Output:
>
> ```bash
>                 Message
> ```

---


## **`ansi::es::cursor`**

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
| begin-down | Move cursor to beginning and down _N_ lines          |
| begin-up   | Move cursor to beginning and up _N_ lines            |
| column     | Move cursor to column _N_                            |
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
> printf "Message: %b\n" "Output$(ansi::es::cursor left 6) Message"
> ```
>
> Output:
>
> ```bash
> Message:  Message
> ```

---


## **`ansi::nc`**

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
> printf "Message: $(ansi::nc bold)%s$(ansi::nc sgr0)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


## **`ansi::nc::color`**

Output ncurses color code for foreground or background

### Arguments

| Name    | Type      | Description                        |
| ------- | :-------: | ---------------------------------- |
| `COLOR` | _integer_ | ncurses color integer (0 - 255)    |
| `ROLE`  | _string_  | [OPTIONAL] Role of color to change |

| Role | Description                |
| ---- | -------------------------- |
| f    | Foreground color [DEFAULT] |
| b    | Background color           |

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
> printf "Message: $(ansi::nc::color 031)%s$(ansi::nc sgr0)" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


## **`ansi::nc::attrib`**

Output ncurses sequence with provided text attribute control code

### Arguments

| Name           | Type     | Description                                             |
| -------------- | :------: | ------------------------------------------------------- |
| `CONTROL_CODE` | _string_ | [OPTIONAL] ncurses sequence text attribute control code |

| Code          | Description                           |
| ------------- | ------------------------------------- |
| standout      | Standout                              |
| standout-off  | Standout off                          |
| invisible     | Blank mode                            |
| reverse       | Swap foreground and background colors |
| blink         | Slow blink                            |
| underline     | Underline text                        |
| underline-off | Underline text off                    |
| italic        | Italic text                           |
| dim           | Dim text                              |
| bold          | Bold text                             |
| reset         | Reset all attributes [DEFAULT]        |

### Exit Codes

| Code | Description                                   |
| ---- | --------------------------------------------- |
| `0`  | Command `tput` exists                         |
| `1`  | Command `tput` turned off, missing, or failed |

### Standard Out

Specified ncurses sequence text attribute control code output

> Example:
>
> ```bash
> printf "Message: $(ansi::nc::attrib bold)%s$(ansi::nc::attrib reset)\n" "Output Message"
> ```
>
> Output:
>
> ```bash
> Message: Output Message
> ```

---


## **`ansi::nc::erase`**

Output ncurses sequence with provided erase control code

### Arguments

| Name           | Type      | Description                                    |
| -------------- | :-------: | ---------------------------------------------- |
| `CONTROL_CODE` | _string_  | [OPTIONAL] ncurses sequence erase control code |
| `VAL`          | _integer_ | [OPTIONAL] Value for CONTROL_CODE              |

| Code  | Description                                                          |
| ----- | -------------------------------------------------------------------- |
| sol   | Erase from cursor position to start of line                          |
| eol   | Erase from cursor position to end of line                            |
| eos   | Erase from cursor position to end of screen                          |
| en    | Erase from cursor _N_ characters                                     |
| ic    | Insert from cursor _N_ characters (moves rest of characters in line) |
| il    | Insert from cursor _N_ lines (moves rest of lines on screen)         |
| clear | Clear the screen [DEFAULT]                                           |

### Exit Codes

| Code | Description                                   |
| ---- | --------------------------------------------- |
| `0`  | Command `tput` exists                         |
| `1`  | Command `tput` turned off, missing, or failed |

### Standard Out

Specified ncurses sequence erase control code output

> Example:
>
> ```bash
> printf "Message: %b\n" "Output$(ansi::nc::erase sol) Message"
> ```
>
> Output:
>
> ```bash
>                 Message
> ```

---


## **`ansi::nc::cursor`**

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
> printf "Message: %b\n" "Output$(ansi::nc::cursor left 6) Message"
> ```
>
> Output:
>
> ```bash
> Message:  Message
> ```
