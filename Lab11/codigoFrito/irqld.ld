ENTRY(_start)
SECTIONS{
  . = 0x0;
  .text : { * (.text); }
  .data : { *(.data) }
  .bss : { *(.bss COMMON) }
  . = ALIGN(8);
  . = . + 0x1000; /* 4kB of stack memory */
  svc_stack_top = .;
  . = . + 0x1000; /* 4kB of stack memory */
  interrupt_stack_top = .;
  . = . + 0x1000; /* 4kB of stack memory */
  stack_taskB = .;
  }
