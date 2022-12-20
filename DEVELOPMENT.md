# Development Environment

It's helpful to have BPKG and Docker installed in your environment, the reset of the tools are provided within the development Docker container; thus not needed on the host system.


- [Development Environment](#development-environment)
  - [Docker](#docker)
    - [**`docker-compose.yml`**](#docker-composeyml)
    - [**`Dockerfile`**](#dockerfile)
    - [**`entrypoint`**](#entrypoint)
  - [Tools](#tools)
    - [BPKG](#bpkg)
      - [BPKG Commands](#bpkg-commands)
    - [Shellcheck](#shellcheck)
    - [shUnit2](#shunit2)
    - [BashCov](#bashcov)

---

## Docker

A Docker container is provided for use in the development environment, the image is specified in the [_`Dockerfile`_](./dev/Dockerfile) definition, the services are defined in the [_`docker-compose.yml`_](./docker-compose.yml) configuration, and a shell script [_`entrypoint`_](./dev/entrypoint) provides a simplified internal environment.

---

### **`docker-compose.yml`**

The configuration file resides in the root of the project and defines the following services:

  - **`shell`** &mdash; Provides a container with the _entrypoint_ to `bash`
  - **`execute`** &mdash; Provides a container with the _entrypoint_ to the project `entrypoint` script

---

### **`Dockerfile`**

The image specification file is located in the project `dev` directory.

It specifies the following:

- Build the image atop the latest [`ruby`](https://hub.docker.com/_/ruby) Docker image
- Ruby Gem [`bashcov` is installed](https://github.com/infertux/bashcov#installation)
- Download and [install `shUnit2`](https://github.com/kward/shunit2)
- Download and run the [BPKG install](https://bpkg.sh#install) script
- Copy Shellcheck from the [shellcheck image](https://hub.docker.com/r/koalaman/shellcheck)

---

### **`entrypoint`**

The script used for the entrypoint is located in the project `dev` directory.  There are functions defined within the script and can be executed by calling them as the first argument.  If it's invoked with no parameter, `bash` is launched.  If the first argument isn't a defined function, the provided arguments will be provided by `exec`.

The entrypoint functions defined:

- **`env_vars`** &mdash; Output entrypoint defined variables
- **`unit-tests`** &mdash; Execute shUnit2 tests
- **`coverage`** &mdash; Execute shUnit2 tests with bashcov
- **`shellchecks`** &mdash; Execute shellcheck against scripts in `src` and `tests` directories

---

## Tools

The provided development environment has several tools.

---

### BPKG

[BPKG](https://bpkg.sh/) is a _bash package manager_.  Located in the root of the project, there is a file named [`bpkg.json`](./bpkg.json); this file specifies information about this project.  You can read more information about this file format on the [Package Guidelines](https://bpkg.sh/guidelines/) page.

The following values are used in this projects BPKG file:

- Name (_name_)
- Description (_description_)
- Command to execute to perform a global install (_install_)
- Array of script files to install when project is used (_scripts_)
- Object of commands for use in the Project development environment (_commands_)

---

#### BPKG Commands

The specified commands can be executed from the command line by calling them by name with the BPKG utilities `run` command:

```bash
$ bpkg run <commmand-name>
```

The configured commands are for building and running within the Docker container.

**Commands:**

- `docker-build` &mdash; Performs a build of the Docker container for the development environment
- `shell` &mdash; Provides a shell terminal (ie: BASH) inside the Docker container
- `execute` &mdash; Allows arbitrary commands to be executed within the Docker container
- `unit-tests` &mdash; **[Shortcut]** Executes `unit-tests` within the Docker container ([`entrypoint`](#entrypoint) function)
- `coverage` &mdash; **[Shortcut]** Executes `coverage` within the Docker container ([`entrypoint`](#entrypoint) function)
- `shellchecks` &mdash; **[Shortcut]** Executes `shellchecks` within the Docker container ([`entrypoint`](#entrypoint) function)

---

### Shellcheck

[Shellcheck](https://github.com/koalaman/shellcheck) is a static analysis tool, to locate syntax issues, semantic problems, and point out subtle caveats, corner cases, and pitfalls.  The project has a [`.shellcheckrc`](./.shellcheckrc) defining project wide directives.  Enabling optional checks (provided with the `--list-optional` flag), external sources, and defining source paths.  

---

### shUnit2

A shell based xUnit testing framework, [shUnit2](https://github.com/kward/shunit2) uses assertion based testing to make sure of expected functionality.  The testing files exist in the [`tests`](./tests) directory; a single tests file for each shell script in the [`src`](./src) directory.  Functions prefaced with the string 'test' (ex: _`test_this_function`_) are treated as tests to perform and will either _pass_ or _fail_.  There are four function names which are specially used during the testing process; one for before all tests (ie: _`oneTimeSetUp`_), one for after all tests (ie: _`oneTimeTearDown`_), one for before each test (ie: _`setUp`_), and one for after each test (ie: _`tearDown`_).

If all setup and teardown functions were defined and there were two tests (ie: `testFirst` and `testSecond`), the following would be the flow of execution:

- `oneTimeSetUp`
  - `setUp`
    - `testFirst` **>** _Store success or failure_
  - `tearDown`
  - `setUp`
    - `testSecond` **>** _Store success or failure_
  - `tearDown`
- `oneTimeTearDown`

---

### BashCov

An execution coverage analysis tool, [Bashcov](https://github.com/infertux/bashcov) is built on SimpleCov, and provides an [HTML report](./coverage/index.html) of how many times each line of code is executed during execution.  By using this utility while running tests, this provides a comprehensive report of which code is covered by tests and which is lacking.  The configuration file (ie: [`.simplecov`](./.simplecov)) defines test suites, groups, and filters as defined by the SimpleCov utility.

The report contains several _tabs_, each listing a grouping of tracked files:

- **All Files** &mdash; All tracked files
- **Library Scripts** &mdash; All scripts in `src` directory
- **Unit Tests** &mdash; Unit test scripts in the `tests` directory
