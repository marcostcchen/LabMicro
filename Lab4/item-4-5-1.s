.text
	.globl main
	
main:
	ldr	r1, =0x10	@ Carrega um valor 10 em Hexa na var y, valor numérico
	adr	r2, array	@ Carrega o endereço base do array que vamos usar
	mov	r3, #20	@ Carrega r3 com 20, para avançar 5 posições no array (4*5)
	
	ldr r4, [r2, r3]	@ Atribui de forma pré indexada array[5] ao registrador r4 
	add	r0,r4,r1	@ Realiza x = array[5] + y e guarda o resultado em r0
	
	ldr r4, [r2], r3 	@ Adiciona o offset ao endereço de r2
	ldr r4, [r2]			
	add r0,r2,r1	        @ Realiza x = array[5] + y e guarda o resultado em r0
			
	SWI 0x0
	
	
array:
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
    .word   0x0000F00B
    .word   0x0000F00C
    .word   0x0000F00D
    .word   0x0000F00E
    .word   0x0000F010
    .word   0x0000F011
    .word   0x0000F012
    .word   0x0000F013
    .word   0x0000F014
    .word   0x0000F015
    .word   0x0000F016
    .word   0x0000F017
    .word   0x0000F018
    .word   0x0000F019
    .word   0x0000F01A
