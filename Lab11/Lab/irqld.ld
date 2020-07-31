ENTRY(_start)
SECTIONS
{
    . = 0x0;
    .text : { * (.text); }
    . = ALIGN(8);
    stack_top = 0x1000;
    undefined_stack_top = 0x2000;
    interrupt_stack_top = 0x3000;
    linhaA = 0x3050;
    linhaB = 0x3100;
    nproc = 0x3150;
}
