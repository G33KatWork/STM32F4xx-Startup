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
	$(call cmd_msg,GDB LOAD,$<)
	$(Q)st-util & $(GDB) -ex "tar ext :4242" -ex "load $<" < /dev/null

debug-gdb-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).elf
	st-util & $(GDB) -ex "tar ext :4242" $<


.PHONY: upload-gdb-$(TARGET) upload-$(TARGET) debug-gdb-$(TARGET)
