.text

	.global main

main:
    LDRB r1, =12 @valor que queremos calcular o fibonacci
    LDRB r2,=0 @offset inicial de 0
    LDRB  r7,=1

    LDRB r3,=0 @f(0) = 0
    LDRB r4,=1 @f(1) = 1
    
    LDR r5,=0x4000 @ end que vamos colocar a sequencia
	STRB r3, [r5] @ store valor de f(0) no primeiro endereco 
    STRB r4, [r5, #1] @ store valor de f(1) com offset

	@ Recursivo principal
	loop:
		@ Verifica se ja chegamos no final da condicao inicial
		CMP r1, #0

		@ Pula fora do loop pois i <= 0
		BLE end

        @ else
        LDRB r3, [r5, r2] @dou load no valor f(n-2)
        ADD r2, r2, #1 @offset = offset + 1
        LDRB r4, [r5, r2] @dou load no valor do f(n-1)
        ADD r6, r4, r3 @valor do fibo(n) = fibo (n-1) + fibo(n-2)
        ADD r7, r7, #1
        STRB r6, [r5, r7]
 
		@ Decrementando 1 no valor
		SUB r1, r1, #1
		BNE loop

end:

	SWI #0
