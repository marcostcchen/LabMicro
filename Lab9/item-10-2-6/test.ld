ENTRY(_Reset)
SECTIONS
{
 . = 0x0;
 .text : {
 startup.o (INTERRUPT_VECTOR)
 *(.text)
 }
 .data : { *(.data) }
 .bss : { *(.bss COMMON) }
 . = ALIGN(8);
 svc_stack_top = 0x1000; /* Pilha supervisor */
 undefined_stack_top = 0x2000; /* Pilha undefined */

}
