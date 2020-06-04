.text

	.global main

main:
	MOV r1, #12
	MOV r2, r1

fib:
	STR lr, [sp], #-4
	
	@ Se x <= 2, retorno 1
	CMP r2, #2
	MOVLE r2, #1
	BLE end

	@ Registradores Auxiliares
	MOV r5, r2 @ salvar o valor de n numa variavel aux que vai ser decrementado
	MOV r2, #0 @ reg auxiliar
	MOV r3, #1 @ fibo(n-1)
	MOV r4, #1 @ fibo(n-2)

	@ Recursivo principal
	loop:
		@ Verifica se ja chegamos no final da condicao inicial
		CMP r5, #2

		@ Retorna o resultado
		MOVLE r0, r4
		BLE end
		
		@ Caso nao chegamos no final, 
		MOV r2, r3 
		ADD r2, r2, r4
		MOV r3, r4
		MOV r4, r2
		LDR r2,=0

		@ Decrementando 1 no valor
		SUB r5, r5, #1
		BNE loop

end:
    LDR r3,=0
    LDR r4,=0
    LDR r5,=0
	SWI #0
