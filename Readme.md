STM32F4xx Startup
=================

This project aims to provide all necessary startup code for
the ST-Microelectronics STM32-F4xx platform.

You can use this code as a starting point for a project on the
STM32F4-Discovery board or any other platform based on this Chip.

Features
--------

* Fancy non-recursive make buildsystem
* Startup code for the platform
* Clock configuration for usage with SDIO and USB
* Newlib support for the heap and dummy-stubs for file I/O
* Integration of the STM32F4xx peripheral library

How to use
----------

You can use this toolchain if you need one: https://launchpad.net/gcc-arm-embedded

After you have installed the toolchain, you can build the library with a simple

	make

If you want to flash it onto your STM32F4-Discovery board using openocd, use

	make upload

or for the faster variant using the [ST-Link utility](https://github.com/texane/stlink) (coming with the toolchain) and gdb, use

	make upload-gdb

For debugging with gdb, use

	make debug-gdb

If you don't use an STLink v2 compatible JTAG adapter, you can change the JTAG_ADAPTER variable in config.mak to match your adapter
if there is already a correspondig rules file in /build/jtag_adapters available. If there isn't you need to write one. Please note,
that at the current time the GDB debugging und uploading make targets are a bit hacky and may not work. Fixes are more than appreciated!

The default firmware which gets uploaded is the hello_world executable. You can override this
behaviour by setting the environment variable **FIRMWARE** to a name of a target or you can use
special targets like **upload-hello_world**.

Example:

	make upload FIRMWARE=your_name_here

or

	make upload-your_name_here
