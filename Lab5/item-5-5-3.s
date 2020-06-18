.text
	.globl main

main:
	MOV r5, #11		@ 11 numeros para comparar
	MOV r0, #1		@ j = 1
	MOV r3, #0		@ reg para guardar temporariamente
	LDR r1, =dados+4	@ ponteiro para o começo dos dados, primeiro end eh pro maior valor
	LDR r2, [r1], #4	@ carrega primeiro valor para o registrador de 'maior numero'

loop:	
	CMP r0, r5		@ j < r5?
	BGE done		@ j >= r5, termina
	
	LDR r3, [r1], #4	@ Carrega próximo numero em r3
	CMP r2, r3		@ Compara numero com maior valor
	MOVLT r2, r3		@ Se o numero de r2 eh menor, colocar no novo numero no lugar
	ADD r0, r0, #1		@ j++
	B loop

done:	
	STR r2, dados		@Armazena maior valor no começo de dados
end:
   	SWI 0x0


dados: 
	.word 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb
