# String

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [< Previous: Script](../script/README.md) ]**


This component module library is named [`bash-util-lib.string.sh`](../../src/bash-util-lib.string.sh).

- [String](#string)
  - [**`string_expand`**](#string_expand)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Out](#standard-out)
  - [**`string_lower`**](#string_lower)
    - [Arguments](#arguments-1)
    - [Standard Out](#standard-out-1)
  - [**`string_upper`**](#string_upper)
    - [Arguments](#arguments-2)
    - [Standard Out](#standard-out-2)
  - [**`preface_lines`**](#preface_lines)
    - [Arguments](#arguments-4)
    - [Standard Out](#standard-out-4)

---


## **`string_expand`**

Output provided input processed to expand variables

### Arguments

| Name    | Type     | Description                    |
| ------- | :------: | ------------------------------ |
| `INPUT` | _string_ | Text to evaluate for expansion |

### Exit Codes

| Code | Description     |
| ---- | --------------- |
| `0`  | String expanded |
| `1`  | String missing  |

### Standard Out

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

---


## **`string_lower`**

String to lowercase

### Arguments

| Name     | Type     | Description                    |
| -------- | :------: | ------------------------------ |
| `STRING` | _string_ | String to convert to lowercase |

### Standard Out

Provided string to lowercase

> Example:
>
> ```bash
> string_lower "LOWERCASE"
> ```
>
> Output:
>
> ```bash
> lowercase
> ```

---


## **`string_upper`**

String to uppercase

### Arguments

| Name     | Type     | Description                    |
| -------- | :------: | ------------------------------ |
| `STRING` | _string_ | String to convert to uppercase |

### Standard Out

Provided string to uppercase

> Example:
>
> ```bash
> string_upper "uppercase"
> ```
>
> Output:
>
> ```bash
> UPPERCASE
> ```

---


## **`preface_lines`**

Preface each line with provided text

### Arguments

| Name      | Type     | Description                                   |
| --------- | :------: | --------------------------------------------- |
| `PREFACE` | _string_ | Characters to prepend to each provided line   |
| `LINES`   | _string_ | Lines of content to prepend specified text to |

### Standard Out

Provided lines of content with specified characters prepended

> Example:
>
> ```bash
> string_repeat " * " "Line 1
> Line 2
> Line 3"
> ```
>
> Output:
>
> ```bash
>  * Line 1
>  * Line 2
>  * Line 3
> ```
