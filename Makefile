# https://www.gnu.org/software/make/manual/html_node/index.html
BIN ?= bash-util-lib
PREFIX ?= /usr/local
CMDS = ansi file script string
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURRENT_DIR := $(patsubst %/,%,$(dir $(MKFILE_PATH)))
DEST_PATH := $(patsubst %/,%,$(abspath $(PREFIX)/bin))

.ONESHELL:

.SILENT: install uninstall link unlink modify-$(DEST_PATH)

modify-$(DEST_PATH):
	test -w $(DEST_PATH) || (\
		echo "\033[91mCan't install:\033[31m permissions failed:\033[34m\033[3m $(DEST_PATH)\033[0m" > /dev/stderr && \
		exit 1 \
	)

install: uninstall
	echo " \033[32m\033[1m* Copy to location:\033[22m\033[3m $(DEST_PATH)\033[0m"
	echo "    \033[94m\033[1m- File:\033[22m\033[3m $(BIN)\033[0m"
	cp $(CURRENT_DIR)/src/$(BIN).sh $(DEST_PATH)/$(BIN)
	for cmd in $(CMDS); do \
		echo "    \033[94m\033[1m- File:\033[22m\033[3m $(BIN).$${cmd}\033[0m"; \
		cp $(CURRENT_DIR)/src/$(BIN).$${cmd}.sh $(DEST_PATH)/$(BIN).$${cmd}; \
	done

uninstall: modify-$(DEST_PATH)
	echo " \033[32m\033[1m* Removing from location:\033[22m\033[3m $(DEST_PATH)\033[0m"
	echo "    \033[94m\033[1m- File:\033[22m\033[3m $(BIN)\033[0m"
	rm -f $(DEST_PATH)/$(BIN)
	for cmd in $(CMDS); do \
		echo "    \033[94m\033[1m- File:\033[22m\033[3m $(BIN).$${cmd}\033[0m"; \
		rm -f $(DEST_PATH)/$(BIN).$${cmd}; \
	done

link: uninstall
	echo " \033[32m\033[1m* Linking from location:\033[22m\033[3m $(CURRENT_DIR)/src\033[0m"
	echo " \033[32m\033[1m* Linking to location:\033[22m\033[3m $(DEST_PATH)\033[0m"
	echo "    \033[94m\033[1m- File:\033[22m\033[3m $(BIN).sh -> $(BIN)\033[0m"
	ln -sr $(CURRENT_DIR)/src/$(BIN).sh $(DEST_PATH)/$(BIN)
	for cmd in $(CMDS); do \
		echo "    \033[94m\033[1m- File:\033[22m\033[3m $(BIN).$${cmd}.sh -> $(BIN).$${cmd}\033[0m"; \
		ln -sr $(CURRENT_DIR)/src/$(BIN).$${cmd}.sh $(DEST_PATH)/$(BIN).$${cmd}; \
	done

unlink: uninstall
