# File

> **Navegate: &nbsp; [ [^ Parent: Manual](../MANUAL.md) &nbsp;&mdash;&nbsp; [< Previous: ANSI](../ansi/README.md) &nbsp;&mdash;&nbsp; [> Next: Script](../script/README.md) ]**

- [File](#file)
  - [**`file_find_line`**](#file_find_line)
    - [Arguments](#arguments)
    - [Exit Codes](#exit-codes)
    - [Standard Out](#standard-out)
  - [**`file_get_lines`**](#file_get_lines)
    - [Arguments](#arguments-1)
    - [Exit Codes](#exit-codes-1)
    - [Standard Out](#standard-out-1)
  - [**`file_expand_lines`**](#file_expand_lines)
    - [Arguments](#arguments-2)
    - [Exit Codes](#exit-codes-2)
    - [Standard Out](#standard-out-2)
  - [**`grab_text_blob`**](#grab_text_blob)
    - [Arguments](#arguments-3)
    - [Exit Codes](#exit-codes-3)
    - [Standard Out](#standard-out-3)

---


## **`file_find_line`**

Output last line number in provided file which matches provided pattern

### Arguments

| Name         | Type     | Description              |
| ------------ | :------: | ------------------------ |
| `FILE_NAME`  | _string_ | File to scan for pattern |
| `PATTERN`    | _string_ | Pattern to scan file for |

### Exit Codes

| Code | Description     |
| ---- | --------------- |
| `0`  | Lines found     |
| `1`  | Lines not found |

### Standard Out

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


## **`file_get_lines`**

Output lines of provided file from provided start line till provided stop line

### Arguments

| Name         | Type      | Description               |
| ------------ | :-------: | ------------------------- |
| `FILE_NAME`  | _string_  | File to clip lines from   |
| `START_LINE` | _integer_ | Line number to begin clip |
| `STOP_LINE`  | _integer_ | Line number to end clip   |

### Exit Codes

| Code | Description     |
| ---- | --------------- |
| `0`  | Lines found     |
| `1`  | Lines not found |

### Standard Out

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


## **`file_expand_lines`**

Output text from section in file specified by provided patterns

### Arguments

| Name            | Type     | Description                         |
| --------------- | :------: | ----------------------------------- |
| `FILE_NAME`     | _string_ | File to clip lines from             |
| `START_PATTERN` | _string_ | Pattern of the start line to output |
| `STOP_PATTERN`  | _string_ | Pattern of the stop line to output  |

### Exit Codes

| Code | Description              |
| ---- | ------------------------ |
| `0`  | Lines found and expanded |
| `1`  | Lines not found          |

### Standard Out

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


## **`grab_text_blob`**

Output text from text blob in file specified by provided blob name

### Arguments

| Name        | Type     | Description                        |
| ----------- | :------: | ---------------------------------- |
| `BLOB_NAME` | _string_ | Name of the blob of text to output |
| `FILE_NAME` | _string_ | File to clip lines from            |

### Exit Codes

| Code | Description         |
| ---- | ------------------- |
| `0`  | Text blob found     |
| `1`  | Text blob not found |

### Standard Out

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
