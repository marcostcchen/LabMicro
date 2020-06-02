    .text
	.globl main

main:

    LDRSB sp, =0xFF03FC06
    LDRSH sp, =0xFF03FC06
    LDR sp, =0xFF03FC06
    LDRB sp, =0xFF03FC06
    SWI 0x0