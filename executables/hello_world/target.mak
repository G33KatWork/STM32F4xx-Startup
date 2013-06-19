# Target file name.
TARGET = hello_world

# List C source files here.
CCSOURCES = Main.c

# List C++ source files here.
CXXSOURCES = 

# List Files to be assembled here
ASOURCES = 

# C compiler flags
CFLAGS  = -std=gnu99 -ggdb -O0 -Werror -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += -fdata-sections -ffunction-sections

# C++ compiler flags
CXXFLAGS = 

# GAS flags
ASFLAGS = 

# Linker flags
LDFLAGS  = -mthumb -mcpu=cortex-m4 -mfix-cortex-m3-ldrd -mfloat-abi=hard -mfpu=fpv4-sp-d16 -nostartfiles
LDFLAGS += -Wl,-T,$(ROOT)/misc/firmware.ld,-Map,$(SELF_DIR)/hello_world/$(TARGET).map -Wl,--gc-sections

# Additional include paths to consider
INCLUDES =	$(ROOT)/libs/cmsis/inc \
            $(ROOT)/libs/libstartup/inc \
            $(ROOT)/libs/libstm32f4xx/inc

# Additional local static libs to link against
LIBS = $(BINARY-libstartup) $(BINARY-libstm32f4xx)

# Folder for object files
OBJDIR = obj

# Folder for sourcecode
SRCDIR = src

# Additional defines
DEFINES := 

include $(ROOT)/build/targets/executable.mak
