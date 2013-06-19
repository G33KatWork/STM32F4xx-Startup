ENTRY(InterruptVectors)

MEMORY
{
	flash (rx)		: ORIGIN = 0x08000000, LENGTH = 1024K
	ccmram (rwx)	: ORIGIN = 0x10000000, LENGTH = 64K
	sram (rwx)		: ORIGIN = 0x20000000, LENGTH = 128K
}

/* Define sections. */
SECTIONS
{
    . = ORIGIN(flash);

    .text : {
        *(.vectors) /* Vector table */
        *(.text*)   /* Program code */
        . = ALIGN(4);
        *(.rodata*) /* Read-only data */
        . = ALIGN(4);
    } >flash

    /* exception index - required due to libgcc.a issuing /0 exceptions */
    __exidx_start = .;
    .ARM.exidx : {
           *(.ARM.exidx*)
    } > flash
    __exidx_end = .;


    _etext = .;

    .data : {
        _data = .;
        *(.data*)   /* Read-write initialized data */
        . = ALIGN(4);
        _edata = .;
    } >ccmram AT >flash

    .bss : {
        *(.bss*)    /* Read-write zero initialized data */
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } >ccmram

    /* exception unwind data - required due to libgcc.a issuing /0 exceptions */
    .ARM.extab : {
        *(.ARM.extab*)
    } >ccmram

    . = ALIGN(4);
    end = .;

    /* Heap */
    . = ALIGN(256);
    _start_heap = .;
}

PROVIDE(_stack = ORIGIN(ccmram) + LENGTH(ccmram));
