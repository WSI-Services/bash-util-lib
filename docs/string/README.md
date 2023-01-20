# String

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [< Previous: Script](../script/README.md) ]**


This component module library is named [`bash-util-lib.string.sh`](../../src/bash-util-lib.string.sh).

- [String](#string)
  - [**`string_expand`**](#string_expand)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Out](#standard-out)

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
