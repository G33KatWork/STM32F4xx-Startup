# Target file name.
TARGET = libstartup

# List C source files here.
CCSOURCES = Debug.c \
			NewlibSyscalls.c \
			SysTick.c \
			Startup.c \
			SystemInit.c \
			USART.c

# List C++ source files here.
CXXSOURCES = 

# C compiler flags
CFLAGS =  -std=gnu99 -ggdb -O0 -Werror -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += -fdata-sections -ffunction-sections

# C++ compiler flags
CXXFLAGS  = 

# List Assembler to be assembled with NASM here
ASOURCES = 

# Additional include paths to consider
INCLUDES =	$(SELF_DIR)/libstm32f4xx/inc \
			$(SELF_DIR)/cmsis/inc \
			$(SELF_DIR)/libstartup/inc

# Folder for object files
OBJDIR = obj

# Folder for sourcecode
SRCDIR = src

# Additional defines
DEFINES := 

include $(ROOT)/build/targets/lib.mak
