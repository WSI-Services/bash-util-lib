# Usage Manual

> **Navegate: &nbsp; [ [^ Parent: Bash Utility Library](../README.md) &nbsp;&mdash;&nbsp; [< Previous: Development Environment](./DEVELOPMENT.md) ]**

- [Usage Manual](#usage-manual)
  - [Usage](#usage)
  - [Library Functions](#library-functions)

---


## Usage

This library is broken into different modules for ease in use and integration.  Each module has its own script file as is described at the top of the associated module documentation.  Each module can be used by sourcing the appropriate file in your script.

```bash
source "deps/bash-util-lib/src/bash-util-lib.ansi.sh"
source "deps/bash-util-lib/src/bash-util-lib.file.sh"
```

The entire library can be loaded by sourcing a single file (which subsequently sources all modules automatically), called [`bash-util-lib.sh`](../src/bash-util-lib.sh).

```bash
source "deps/bash-util-lib/src/bash-util-lib.sh"
```

If using this project with [BPKG](./DEVELOPMENT.md#bpkg), and want to provide a dynamically sourced path (which allows for both locally and globally installed paths), the following can be used.

```bash
__SCRIPT_DIRNAME="$(dirname "${BASH_SOURCE[0]}")"

# Add dependency bin to PATH
if [[ -d "${__SCRIPT_DIRNAME}/${BPKG_DEPS:-deps}/bin" ]]; then
    PATH="${__SCRIPT_DIRNAME}/${BPKG_DEPS:-deps}/bin:${PATH}"
fi

source "bash-util-lib.ansi.sh"
source "bash-util-lib.file.sh"
```

This adds the project dependency `bin` directory (if it exists) to the environment `PATH`, before performing the `source`; allowing for ease of use during development as well as in production deployment.

---


## Library Functions

This bash utility library provides functions to simplify writing and running bash scripts.  This section lists the available files, the functions provided, and the usage of them.

- [ANSI](./ansi/README.md)
- [File](./file/README.md)
- [Script](./script/README.md)
- [String](./string/README.md)
