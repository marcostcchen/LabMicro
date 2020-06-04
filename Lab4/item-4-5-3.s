.text
	.globl main

main:
    ADR  r1, a @ endereco do array a
    ADR	 r2, b @ endereco do array b
    MOV  r3, #0 @ var i
    MOV  r4, #1 @ var c
    MOV  r5, #0 @ var temp para carregar valor de b[i]

loop:
    CMP r3, #11 	@ i > 10 ?
    BPL final
    LDR	r5, [r2], #4 	@ pega valor de b[i]
    ADD r5, r5, r4 	@ r5 = b[i] + c	
    STR r5, [r1], #4	@ a[i] = r5
    ADD r3, r3, #1	@ incrementa i
    B loop
     
final:       
     SWI 0x0

a:
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000
    .word   0x00000000

b:
    .word   0x0000F000
    .word   0x0000F001
    .word   0x0000F002
    .word   0x0000F003
    .word   0x0000F004
    .word   0x0000F005
    .word   0x0000F006
    .word   0x0000F007
    .word   0x0000F008
    .word   0x0000F009
    .word   0x0000F00A

