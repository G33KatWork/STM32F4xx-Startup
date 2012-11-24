ROOT := $(PWD)
include $(ROOT)/build/base.mak

FIRMWARE ?= hello_world

STARTTIME := $(shell date +%s)
# Main targets
all:
	$(call cmd_msg,NOTICE,Build completed in $$(($$(date +%s)-$(STARTTIME))) seconds)

upload: upload-$(FIRMWARE)
upload-gdb: upload-gdb-$(FIRMWARE)
debug-gdb: debug-gdb-$(FIRMWARE) 

.PHONY: all clean upload upload-gdb debug-gdb

SUBDIRS = libs executables
SELF_DIR = $(ROOT)/
include $(abspath $(addprefix $(SELF_DIR),$(addsuffix /target.mak,$(SUBDIRS))))
