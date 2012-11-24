ENTRY(InterruptVectors)

MEMORY
{
	flash (rx)		: ORIGIN = 0x08000000, LENGTH = 1024K
	ccmram (rwx)	: ORIGIN = 0x10000000, LENGTH = 64K
	sram (rwx)		: ORIGIN = 0x20000000, LENGTH = 128K
}

_estack = 0x10010000; /* highest stack address */

SECTIONS
{
    /* .text and .rodata sections */
    .text :
    {
        /* Mark start of text section */
        _text = .;

        /* Interrupt vectors */
        __isr_vector_start = .;
        KEEP(*(.isr_vector))
        __isr_vector_end = .;

        *(.text*)
        *(.rodata*)
        _etext = .;
        _idata = .;

    } > flash

    /* .data section */
    .data : AT(ADDR(.text) + SIZEOF(.text))
    {
        _data = .;
        *(vtable)
        *(.data*)
        _edata = .;
    } > ccmram

    /*.bss section*/
    .bss :
    {
        _bss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > ccmram

    end = .;

    /* Heap */
    . = ALIGN(256);
    _start_heap = .;

    /* Stack */
    /* defined by _estack at the top of script */

    .ARM.attributes 0 : { KEEP (*(.ARM.attributes)) }

    /* Remove debug information from the standard libraries */
    /DISCARD/ :
    {
        *(.note.GNU-stack)
        libc.a ( * )
        libgcc.a ( * )
        libm.a ( * )
    }
}
