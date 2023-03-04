# String

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [< Previous: Script](../script/README.md) ]**


This component module library is named [`bash-util-lib.string.sh`](../../src/bash-util-lib.string.sh).

- [String](#string)
  - [**`string::expand`**](#stringexpand)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Out](#standard-out)
  - [**`string::lower`**](#stringlower)
    - [Arguments](#arguments-1)
    - [Standard Out](#standard-out-1)
  - [**`string::upper`**](#stringupper)
    - [Arguments](#arguments-2)
    - [Standard Out](#standard-out-2)
  - [**`string::repeat`**](#stringrepeat)
    - [Arguments](#arguments-3)
    - [Standard Out](#standard-out-3)
  - [**`string::preface`**](#stringpreface)
    - [Arguments](#arguments-4)
    - [Standard Out](#standard-out-4)

---


## **`string::expand`**

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
> string::expand "Output: \${STRING}"
> ```
>
> Output:
>
> ```bash
> Output: Test
> ```

---


## **`string::lower`**

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
> string::lower "LOWERCASE"
> ```
>
> Output:
>
> ```bash
> lowercase
> ```

---


## **`string::upper`**

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
> string::upper "uppercase"
> ```
>
> Output:
>
> ```bash
> UPPERCASE
> ```

---


## **`string::repeat`**

Repeat provided string specified times

### Arguments

| Name     | Type      | Description                                               |
| -------- | :-------: | --------------------------------------------------------- |
| `COUNT`  | _integer_ | Number of times to repeat provided string                 |
| `STRING` | _string_  | [OPTIONAL] String to repeat specified times, default: ' ' |

### Standard Out

Provided string repeated specified times

> Example:
>
> ```bash
> string::repeat 3 " -=*=-"
> ```
>
> Output:
>
> ```bash
>  -=*=- -=*=- -=*=-
> ```

---


## **`string::preface`**

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
> string::preface " * " "Line 1
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
