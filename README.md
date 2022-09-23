# Bash-Util-Lib - Bash Utility Library

A library of bash utility functions (from output colors to parameter processing) for use in small projects.


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


## Usage

Bash utility functions can be used by sourcing the library file in your script.  To access the functions within the library, you should import the main bash library as follows.

```bash
source "deps/bash-util/bash-util-lib.sh"
```


## Library Functions

This bash utility library provides functions to simplify writing and running bash scripts.  This section lists the available functions and usage of them.

---


### **`es`**

Output escape sequence with provided control code if **`ES_USE`** environment variable is true

#### Arguments

| Name            | Type     | Description                         |
| --------------- | :------: | ----------------------------------- |
| `CONTROL_CODE`  | _string_ | Argument to pass to escape sequence |

#### Exit Codes

| Code | Description                          |
| ---- | ------------------------------------ |
| `0`  | Command control code output sequence |
| `1`  | Command control code failed          |

#### Standard Out

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

#### Environment Variables

| Variable       | Default         | Description                                         |
| -------------- | --------------- | --------------------------------------------------- |
| `ES_USE`       | `true`          | Value as to whether to use escape sequence commands |

---


### **`nc`**

Call ncurses `tput` command with provided arguments if command exists (**`CMD_TPUT`**) and **`NC_USE`** environment variable is true

#### Arguments

| Name | Type    | Description                                 |
| ---- | :-----: | ------------------------------------------- |
| `@`  | _array_ | Arguments to pass to ncurses command `tput` |

#### Exit Codes

| Code | Description                         |
| ---- | ----------------------------------- |
| `0`  | Command `tput` exists and succeeded |
| `1`  | Command `tput` missing or failed    |

#### Standard Out

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

#### Environment Variables

| Variable       | Default         | Description                                 |
| -------------- | --------------- | ------------------------------------------- |
| `CMD_TPUT`     | `$(which tput)` | Path to `tput` command utility              |
| `NC_USE`       | `true`          | Value as to whether to use ncurses commands |

---


### **`exit_err`**

Output provided error message, optionally additional message, and exit with provided code

#### Arguments

| Name       | Type      | Description                             |
| ---------- | :-------: | --------------------------------------- |
| `ERR_CODE` | _integer_ | Exit code                               |
| `ERR_MSG`  | _string_  | Message to output                       |
| `ADD_MSG`  | _string_  | [OPTIONAL] Additional message to output |

#### Exit Codes

| Code | Description                  |
| ---- | ---------------------------- |
| `?`  | Provided `ERR_CODE` argument |

#### Standard Error

Provided **ERR_CODE** and **ERR_MSG** using the **EXIT_ERR_MSG_ERROR** format; and optional **UTIL_SCRIPT_CMD** (if set) using the **EXIT_ERR_MSG_COMMAND** format

#### Standard Out

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

#### Environment Variables

| Variable                  | Default                | Description                                                   |
| ------------------------- | ---------------------- | ------------------------------------------------------------- |
| `EXIT_ERR_MSG_ERROR`      | `Error [%i]: %b\n`     | Variable to store `printf` style string for error message     |
| `EXIT_ERR_MSG_COMMAND`    | `Command failed: %b\n` | Variable to store `printf` style string for command string    |
| `EXIT_ERR_MSG_ADDITIONAL` | `%s\n`                 | Variable to store `printf` style string for additional string |
| `UTIL_SCRIPT_CMD`         |                        | Variable to hold command string                               |

---


### **`function_exists`**

Returns status of function existing

#### Arguments

| Name            | Type     | Description                       |
| --------------- | :------: | --------------------------------- |
| `FUNCTION_NAME` | _string_ | Name of function to check for     |

#### Exit Codes

| Code | Description             |
| ---- | ----------------------- |
| `0`  | Function exists         |
| `1`  | Function does not exist |

#### Standard Out

> Example:
>
> ```bash
> function_exists "missing_test"
> ```
>
> Exit Code: 1
