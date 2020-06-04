.text
	.globl main
	
main:

	adr r1, array	@ Carrega o endereço base do array que vamos usar
    ldrb r2, =10 @valor de s

    ldrb r3, =0 @valor de i
    ldrb r4, =0 @valor 0
    b loop

loop:

    CMP r3, r2
    STRB r4, [r1, r3]
    ADD r3, r3, #1
    BNE loop

end:
	SWI 0x0
	
array:
  .byte 0,1,2,3,4,5,6,7
