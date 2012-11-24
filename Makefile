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

SUBDIRS = libs executables
SELF_DIR = $(ROOT)/
include $(abspath $(addprefix $(SELF_DIR),$(addsuffix /target.mak,$(SUBDIRS))))

#Installation stuff for the libraries
#FIXME: make this configurable via the targets
installlibs: all
	$(Q)$(MKDIR) -p $(ROOT)/install/{inc,lib}
	$(Q)$(CP) -r $(ROOT)/libs/cmsis/inc/* $(ROOT)/install/inc
	$(Q)$(CP) -r $(ROOT)/libs/libstartup/inc/* $(ROOT)/install/inc
	$(Q)$(CP) -r $(ROOT)/libs/libstm32f4xx/inc/* $(ROOT)/install/inc
	$(Q)$(AR) x $(BINARY-libstartup)
	$(Q)$(AR) x $(BINARY-libstm32f4xx)
	$(Q)$(AR) rcs $(ROOT)/install/lib/libstartup.a  *.o
	$(Q)$(RM) *.o

cleaninstall:
	$(Q)$(RM) -rf $(ROOT)/install

clean: cleaninstall

.PHONY: all clean upload upload-gdb debug-gdb install cleaninstall
