ENTRY(_start)
SECTIONS{
    . = 0x0;
    .text : { * (.text); }
    .data : { *(.data) }
    .bss : { *(.bss COMMON) }
    . = ALIGN(8);
    
    . = . + 0x1000; /* 4kB of stack memory */
    svc_stack_top = .; /* Pilha supervisor */

    . = . + 0x1000; /* 4kB of stack memory */
    irq_stack_top = .; /* Pilha IRQ */

    . = . + 0x1000; /* 4kB of stack memory */
    linhaA = .; /* Estrutura de Dados */
}