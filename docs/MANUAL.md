# Usage Manual

> **Navegate: &nbsp; [ [^ Parent: Bash Utility Library](../README.md) &nbsp;&mdash;&nbsp; [< Previous: Development Environment](./DEVELOPMENT.md) ]**

- [Usage Manual](#usage-manual)
  - [Usage](#usage)
  - [Library Functions](#library-functions)

---


## Usage

Bash utility functions can be used by sourcing the library files in your script.  To access the functions within the library, you should import the main bash library as follows.

```bash
source "deps/bash-util-lib/src/bash-util-lib.ansi.sh"
source "deps/bash-util-lib/src/bash-util-lib.file.sh"
source "deps/bash-util-lib/src/bash-util-lib.script.sh"
source "deps/bash-util-lib/src/bash-util-lib.string.sh"
```

If you want to provide a dynamic source include, allowing local or global path, add the project dependency bin directory to the environment `PATH` before performing the `source`.

```bash
__SCRIPT_DIRNAME="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Add dependency bin to PATH
if [[ -d "${__SCRIPT_DIRNAME}/${BPKG_DEPS:-deps}/bin" ]]; then
    PATH="${__SCRIPT_DIRNAME}/${BPKG_DEPS:-deps}/bin:${PATH}"
fi

source "bash-util-lib.ansi"
source "bash-util-lib.file"
source "bash-util-lib.script"
source "bash-util-lib.string"
```

---


## Library Functions

This bash utility library provides functions to simplify writing and running bash scripts.  This section lists the available files, the functions provided, and the usage of them.

- [ANSI](./ansi/README.md)
- [File](./file/README.md)
- [Script](./script/README.md)
- [String](./string/README.md)
