# Install

> **Navegate: &nbsp; [ [^ Parent: Bash Utility Library](../README.md) &nbsp;&mdash;&nbsp; [> Next: Development Environment](./DEVELOPMENT.md) ]**

- [Install](#install)
  - [GIT Submodules](#git-submodules)
  - [GIT Clone](#git-clone)
  - [Direct Download](#direct-download)
  - [Bash Package](#bash-package)

---

The library can be installed using the following methods.

---


## GIT Submodules

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

---


## GIT Clone

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

---


## Direct Download

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

---


## Bash Package

If you have the Bash Package Manager (ie: _[bpkg](http://www.bpkg.sh/)_) you can download the associated `wsi-services/bash-util-lib` package:

```bash
bpkg install wsi-services/bash-util-lib
```
