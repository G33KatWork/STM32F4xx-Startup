#Define used JTAG adapter here, included files for different adapters are located in /build/jtag_adapters
JTAG_ADAPTER := stlink_v2
#JTAG_ADAPTER := jlink

#enter global defines here
GLOBAL_DEFINES := -DDEBUG -DDEBUG_NO_FLOAT_PRINTF -DUSE_FULL_ASSERT

#TODO: same for cflags and ldflags?
