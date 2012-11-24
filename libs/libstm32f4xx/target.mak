# Target file name.
TARGET = libstm32f4xx

# List C source files here.
CCSOURCES = misc.c \
			stm32f4xx_cryp_aes.c \
			stm32f4xx_dac.c \
			stm32f4xx_exti.c \
			stm32f4xx_hash.c \
			stm32f4xx_iwdg.c \
			stm32f4xx_rtc.c \
			stm32f4xx_tim.c \
			stm32f4xx_adc.c \
			stm32f4xx_cryp.c \
			stm32f4xx_dbgmcu.c \
			stm32f4xx_flash.c \
			stm32f4xx_hash_md5.c \
			stm32f4xx_pwr.c \
			stm32f4xx_sdio.c \
			stm32f4xx_usart.c \
			stm32f4xx_can.c \
			stm32f4xx_cryp_des.c \
			stm32f4xx_dcmi.c \
			stm32f4xx_fsmc.c \
			stm32f4xx_hash_sha1.c \
			stm32f4xx_rcc.c \
			stm32f4xx_spi.c \
			stm32f4xx_wwdg.c \
			stm32f4xx_crc.c \
			stm32f4xx_cryp_tdes.c \
			stm32f4xx_dma.c \
			stm32f4xx_gpio.c \
			stm32f4xx_i2c.c \
			stm32f4xx_rng.c \
			stm32f4xx_syscfg.c

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
			$(SELF_DIR)/cmsis/inc

# Folder for object files
OBJDIR = obj

# Folder for sourcecode
SRCDIR = src

# Additional defines
DEFINES := 

include $(ROOT)/build/targets/lib.mak
