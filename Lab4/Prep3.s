    .text
	.globl main

main:

    LDR R3, =0x4000
    LDR R4, =0x20
    @STRB R6, [R3, R4]
    @LDRB R8, [R3, R4, LSL #3]
    @LDR R7, [R3], R4
    MOV R1, R3, ASR #2
    SWI 0x0
    