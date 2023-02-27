# ANSI Constants

> **Navegate: &nbsp; [ [^ Parent: ANSI](../README.md) ]**


This component module library is named [`bash-util-lib.ansi.const.sh`](../../../src/bash-util-lib.ansi.const.sh).

- [ANSI Constants](#ansi-constants)
  - [Environment Variables](#environment-variables)

---


## Environment Variables

| Variable                 | Description                                                                                            |
| ------------------------ | ------------------------------------------------------------------------------------------------------ |
| `ANSI_ESC`               | ANSI code sequence prefix character (ASCII 27 - `ESC` character)                                       |
| `ANSI_CSI`               | ANSI Control Sequence Introducer: ANSI sequence prefix (Sequence: `ESC` followed by the `[` character) |
| `ANSI_DCS`               | ANSI Device Control String: ANSI sequence prefix (Sequence: `ESC` followed by the `P` character)       |
| `ANSI_OSC`               | ANSI Operating System Command: ANSI sequence prefix (Sequence: `ESC` followed by the `]` character)    |
| `ANSI_RESET`             | ANSI code to _reset_ all text attributes and colors                                                    |
| `ANSI_BOLD`              | ANSI code to _set_ text **bold** attribute modifier                                                    |
| `ANSI_FAINT`             | ANSI code to _set_ text **faint** attribute modifier                                                   |
| `ANSI_ITALIC`            | ANSI code to _set_ text **italic** attribute modifier                                                  |
| `ANSI_UNDERLINE`         | ANSI code to _set_ text **underline** attribute modifier                                               |
| `ANSI_BLINK`             | ANSI code to _set_ text **blink** attribute modifier                                                   |
| `ANSI_BLINK_FAST`        | ANSI code to _set_ text **blink-fast** attribute modifier                                              |
| `ANSI_SWAP`              | ANSI code to _set_ text **swap** attribute modifier                                                    |
| `ANSI_HIDDEN`            | ANSI code to _set_ text **hidden** attribute modifier                                                  |
| `ANSI_STRIKE`            | ANSI code to _set_ text **strike** attribute modifier                                                  |
| `ANSI_OVERLINE`          | ANSI code to _set_ text **overline** attribute modifier                                                |
| `ANSI_BOLD_RESET`        | ANSI code to _unset_ text **bold** attribute modifier                                                  |
| `ANSI_FAINT_RESET`       | ANSI code to _unset_ text **faint** attribute modifier                                                 |
| `ANSI_ITALIC_RESET`      | ANSI code to _unset_ text **italic** attribute modifier                                                |
| `ANSI_UNDERLINE_RESET`   | ANSI code to _unset_ text **underline** attribute modifier                                             |
| `ANSI_BLINK_RESET`       | ANSI code to _unset_ text **blink** or **blink-fast** attribute modifier                               |
| `ANSI_SWAP_RESET`        | ANSI code to _unset_ text **swap** attribute modifier                                                  |
| `ANSI_HIDDEN_RESET`      | ANSI code to _unset_ text **hidden** attribute modifier                                                |
| `ANSI_STRIKE_RESET`      | ANSI code to _unset_ text **strike** attribute modifier                                                |
| `ANSI_OVERLINE_RESET`    | ANSI code to _unset_ text **overline** attribute modifier                                              |
| `ANSI_BLACK`             | ANSI code to _set_ text _foreground_ color to **black**                                                |
| `ANSI_RED`               | ANSI code to _set_ text _foreground_ color to **red**                                                  |
| `ANSI_GREEN`             | ANSI code to _set_ text _foreground_ color to **green**                                                |
| `ANSI_YELLOW`            | ANSI code to _set_ text _foreground_ color to **yellow**                                               |
| `ANSI_BLUE`              | ANSI code to _set_ text _foreground_ color to **blue**                                                 |
| `ANSI_MAGENTA`           | ANSI code to _set_ text _foreground_ color to **magenta**                                              |
| `ANSI_CYAN`              | ANSI code to _set_ text _foreground_ color to **cyan**                                                 |
| `ANSI_WHITE`             | ANSI code to _set_ text _foreground_ color to **white**                                                |
| `ANSI_DEFAULT`           | ANSI code to _unset_ text _foreground_ color                                                           |
| `ANSI_BLACK_BG`          | ANSI code to _set_ text _background_ color to **black**                                                |
| `ANSI_RED_BG`            | ANSI code to _set_ text _background_ color to **red**                                                  |
| `ANSI_GREEN_BG`          | ANSI code to _set_ text _background_ color to **green**                                                |
| `ANSI_YELLOW_BG`         | ANSI code to _set_ text _background_ color to **yellow**                                               |
| `ANSI_BLUE_BG`           | ANSI code to _set_ text _background_ color to **blue**                                                 |
| `ANSI_MAGENTA_BG`        | ANSI code to _set_ text _background_ color to **magenta**                                              |
| `ANSI_CYAN_BG`           | ANSI code to _set_ text _background_ color to **cyan**                                                 |
| `ANSI_WHITE_BG`          | ANSI code to _set_ text _background_ color to **white**                                                |
| `ANSI_DEFAULT_BG`        | ANSI code to _unset_ text _background_ color                                                           |
| `ANSI_BRIGHT_BLACK`      | ANSI code to _set_ text _foreground_ color to **bright black**                                         |
| `ANSI_BRIGHT_RED`        | ANSI code to _set_ text _foreground_ color to **bright red**                                           |
| `ANSI_BRIGHT_GREEN`      | ANSI code to _set_ text _foreground_ color to **bright green**                                         |
| `ANSI_BRIGHT_YELLOW`     | ANSI code to _set_ text _foreground_ color to **bright yellow**                                        |
| `ANSI_BRIGHT_BLUE`       | ANSI code to _set_ text _foreground_ color to **bright blue**                                          |
| `ANSI_BRIGHT_MAGENTA`    | ANSI code to _set_ text _foreground_ color to **bright magenta**                                       |
| `ANSI_BRIGHT_CYAN`       | ANSI code to _set_ text _foreground_ color to **bright cyan**                                          |
| `ANSI_BRIGHT_WHITE`      | ANSI code to _set_ text _foreground_ color to **bright white**                                         |
| `ANSI_BRIGHT_BLACK_BG`   | ANSI code to _set_ text _background_ color to **bright black**                                         |
| `ANSI_BRIGHT_RED_BG`     | ANSI code to _set_ text _background_ color to **bright red**                                           |
| `ANSI_BRIGHT_GREEN_BG`   | ANSI code to _set_ text _background_ color to **bright green**                                         |
| `ANSI_BRIGHT_YELLOW_BG`  | ANSI code to _set_ text _background_ color to **bright yellow**                                        |
| `ANSI_BRIGHT_BLUE_BG`    | ANSI code to _set_ text _background_ color to **bright blue**                                          |
| `ANSI_BRIGHT_MAGENTA_BG` | ANSI code to _set_ text _background_ color to **bright magenta**                                       |
| `ANSI_BRIGHT_CYAN_BG`    | ANSI code to _set_ text _background_ color to **bright cyan**                                          |
| `ANSI_BRIGHT_WHITE_BG`   | ANSI code to _set_ text _background_ color to **bright white**                                         |
