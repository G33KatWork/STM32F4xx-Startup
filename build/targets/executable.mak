#current directory
#FIXME: this looks strange somehow...
CURDIR-$(TARGET) := $(SELF_DIR)$(TARGET)

# Variable mangling
OBJDIR-$(TARGET) := $(addprefix $(CURDIR-$(TARGET))/,$(OBJDIR))
SRCDIR-$(TARGET) := $(addprefix $(CURDIR-$(TARGET))/,$(SRCDIR))

# C compiler flags
CFLAGS-$(TARGET) := $(CFLAGS)
CFLAGS-$(TARGET) += $(addprefix -I,$(INCLUDES))
CFLAGS-$(TARGET) += $(DEFINES)

# C++ compiler flags
CXXFLAGS-$(TARGET) := $(CXXFLAGS)
CXXFLAGS-$(TARGET) += $(addprefix -I,$(INCLUDES))
CXXFLAGS-$(TARGET) += $(DEFINES)

# LD flags
LDFLAGS-$(TARGET) := $(LDFLAGS)

# Determinte objects to be created
OBJECTS-$(TARGET) := $(ASOURCES:%.S=%.o)
OBJECTS-$(TARGET) += $(CCSOURCES:%.c=%.o)
OBJECTS-$(TARGET) += $(CXXSOURCES:%.cpp=%.o)

# Build lib search directories
LIBS-$(TARGET) := $(LIBS)

# Build dependency list of libraries
LIBDEPS-$(TARGET) := $(LIBS)

# A name to reference tis target
BINARY-$(TARGET) := $(OBJDIR-$(TARGET))/$(TARGET).bin

# Main targets
all: $(BINARY-$(TARGET))
$(TARGET): $(BINARY-$(TARGET))

$(OBJDIR-$(TARGET))/$(TARGET).bin: $(OBJDIR-$(TARGET))/$(TARGET).elf
	$(call cmd_msg,OBJCOPY,$^ -> $(@))
	$(Q)$(OBJCOPY) -O binary $< $@
	
$(OBJDIR-$(TARGET))/$(TARGET).elf: LDFLAGS := $(LDFLAGS-$(TARGET))
$(OBJDIR-$(TARGET))/$(TARGET).elf: $(addprefix $(OBJDIR-$(TARGET))/,$(OBJECTS-$(TARGET))) $(LIBDEPS-$(TARGET))
	$(call cmd_msg,LINK,$(@))
	$(Q)$(CC) $(LDFLAGS) -o $@ -Wl,--whole-archive $^ -Wl,--no-whole-archive

# Cleaning
clean: clean-$(TARGET)
clean-$(TARGET): clean-% :
	$(Q)$(RM) -f $(CURDIR-$*)/*.map
	$(Q)$(RM) -rf $(OBJDIR-$*)

# Header dependency generation
$(OBJDIR-$(TARGET))/%.d: CFLAGS := $(CFLAGS-$(TARGET))
$(OBJDIR-$(TARGET))/%.d: $(SRCDIR-$(TARGET))/%.c
#	$(call cmd_msg,DEPENDS,$@)
	$(Q)$(MKDIR) -p $(dir $@)
	$(Q)$(CC) $(CFLAGS) -MM -MG -MP -MT '$(@:%.d=%.o)' $< > $@

$(OBJDIR-$(TARGET))/%.d: CXXFLAGS := $(CXXFLAGS-$(TARGET))
$(OBJDIR)/%.d: $(SRCDIR)/%.cpp
#	$(call cmd_msg,DEPENDS,$@)
	$(Q)$(MKDIR) -p $(dir $@)
	$(Q)$(CXX) $(CXXFLAGS) -MM -MG -MP -MT '$(@:%.d=%.o)' $< > $@

# Compile c files
$(OBJDIR-$(TARGET))/%.o: CFLAGS := $(CFLAGS-$(TARGET))
$(OBJDIR-$(TARGET))/%.o: $(SRCDIR-$(TARGET))/%.c
	$(call cmd_msg,CC,$<)
	$(Q)$(MKDIR) -p $(dir $@)
	$(Q)$(CC) $(CFLAGS) -c $< -o $@

# Compile cpp files
$(OBJDIR-$(TARGET))/%.o: CXXFLAGS := $(CXXFLAGS-$(TARGET))
$(OBJDIR-$(TARGET))/%.o: $(SRCDIR-$(TARGET))/%.cpp
	$(call cmd_msg,CXX,$<)
	$(Q)$(MKDIR) -p $(dir $@)
	$(Q)$(CXX) $(CXXFLAGS) -c $< -o $@

# Assemble S files with GAS
$(OBJDIR-$(TARGET))/%.o: ASFLAGS := $(ASFLAGS-$(TARGET))
$(OBJDIR-$(TARGET))/%.o: $(SRCDIR-$(TARGET))/%.S
	$(call cmd_msg,AS,$<)
	$(Q)$(MKDIR) -p $(dir $@)
	$(Q)$(CC) -c $(ASFLAGS) -o $@ $<

upload-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).bin
	$(call cmd_msg,OPENOCD,$<)
	$(Q)openocd -f interface/stlink-v2.cfg -f target/stm32f4x_stlink.cfg \
	-c init -c "reset halt" -c "stm32f2x mass_erase 0" \
	-c "flash write_bank 0 $^ 0" \
	-c "reset run" -c shutdown

upload-fast-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).bin
	$(call cmd_msg,STLINK,$<)
	$(Q)st-flash write $< 0x8000000

upload-gdb-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).elf
	$(call cmd_msg,GDB,$<)
	$(Q)st-util & $(GDB) -ex "tar ext :4242" -ex "load $<" < /dev/null

debug-gdb-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).elf
	st-util & $(GDB) -ex "tar ext :4242" $<

.PHONY: clean-$(TARGET) $(TARGET) upload-gdb-$(TARGET) upload-$(TARGET) debug-gdb-$(TARGET)

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(MAKECMDGOALS),distclean)
ifneq ($(MAKECMDGOALS),clean-$(TARGET))
-include $(addprefix $(OBJDIR-$(TARGET))/, $(OBJECTS-$(TARGET):%.o=%.d))
endif
endif
endif
