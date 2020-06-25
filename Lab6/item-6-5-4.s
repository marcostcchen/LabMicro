.text
	.globl main

main:

	MOV r0, #2		@ Carrega tipo de dado 'halfword'
	MOV r1, #5		@ Dado a ser armazenado

push:	
	CMP r0, #1		@ Dado é um byte
	STREQB r1, [sp], #4
	CMP r0, #2		@ Dado é uma hw
	STREQH r1, [sp], #4
	CMP r0, #4		@ Dado é uma word
	STREQ r1, [sp], #4	@ Salva r1 na pilha com offset do tamanho da palavra

end:
   	SWI 0x0
