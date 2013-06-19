upload-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).bin
	$(call cmd_msg,OPENOCD,$<)
	$(Q)openocd -f interface/jlink.cfg -f target/stm32f4x.cfg \
	-c init -c "reset halt" -c "stm32f2x mass_erase 0" \
	-c "flash write_bank 0 $^ 0" \
	-c "reset run" -c shutdown

upload-gdb-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).elf
	$(call cmd_msg,GDB LOAD,$<)
	$(Q)openocd -f interface/jlink.cfg -f target/stm32f4x.cfg & \
	sleep 2 && $(GDB) -ex "tar ext :3333" -ex "monitor reset init" \
	-ex "load $<" -ex "monitor shutdown" < /dev/null

debug-gdb-$(TARGET): $(OBJDIR-$(TARGET))/$(TARGET).elf
	$(Q)openocd -f interface/jlink.cfg -f target/stm32f4x.cfg & \
	sleep 2 && $(GDB) -ex "tar ext :3333" -ex "monitor reset init" \
	-ex "load $<" $<


.PHONY: upload-gdb-$(TARGET) upload-$(TARGET) debug-gdb-$(TARGET)
