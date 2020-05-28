@ gcc -o division division.s
@ gdb division

    .text
	.globl main

main:

    LDR  R1,=0x960A69 @Load do dividendo
    LDR  R2,=0x3E8 @Load do divisor
    MOV  R7, R1 @Salvo o valor do dividendo 

    CMP R2, #0 @Verificacao se nao estamos dividindo por zero
    BEQ divide_end #Caso for igual a zero, vai para a funcao que termina a divisao

    MOV  R3,#0 @Inicializo R3 com zero, o R3 será responsavel por acumular o resultado
    MOV  R6,#1 @Inicializo R6 com um e vai ser o valor que iremos realizar as operacoes de shift left e shift right

    BLS start  
                      
@Loop inicial para verificar quantos shiftsLefts iremos realizar
start:
    CMP      R2,R1 @Subtrai o valor de R2 com R1 e atualizo as flags
    MOVLS    R2,R2,LSL#1 @Faz o shiftleft no valor do divisor, para caso as flags C = 0 e Z = 1, ou seja, quando o R2 for menor ou igual a R1
    MOVLS    R6,R6,LSL#1 @@Faz o shiftleft no valor do numero acumulado, para a mesma condicao
    BLS      start @Faz a branch caso C = 1 ou Z = 1, caso C = 0 e Z = 0, ele passa para a etapa next

@Continua a execução para multiplicarmos o numero de vezes de shift left que acumulamos
next:
    CMP       R1,R2      
    SUBCS     R1,R1,R2 @Subtrai caso maior ou igual C=1

    ADDCS     R3,R3,R6 @Adiciona caso maior ou igual C=1
                        
    MOVS      R6,R6,LSR#1 
    MOVCC     R2,R2,LSR#1 @Faz o mov para caso menor C=0
                         
    BCC       next @Volta ao loop para caso menor R1 menor que R2 C=0
                           
divide_end:
@Realocamos os resultados de volta para os registradores de resposta
    MOV R5, R1 
    MOV R1, R7
    SWI 0x0
            
@Resultados: R5 resto, R2 dividendo, R3 resultado, R6 zero, R1 valor do divisor
