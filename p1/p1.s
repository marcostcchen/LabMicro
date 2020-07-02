@ O valor de N é inserido em R0
@ Para compilar gcc -o p1 p1.s

.text
	.globl main

main:
    LDR R0,=240 @Valor de N em decimal
    LDR R2,=2 @Valor inicial
    ADR R3, divide @load no endereco do array
    LDR R4,=0 @offset do array

    B criarVetor

criarVetor:
    CMP R2, R0
    BEQ end
    BL divisao

    CMP R8, #0
    BLEQ acrescentaNoArray
    ADD R2, R2, #1
    B criarVetor

acrescentaNoArray:
    STR R2, [R3, R4] @Armazeno o valor no array
    ADD R4, R4, #4 @proximo endereco do array
    MOV PC,LR  @volta para a funcao que realizou a chamada  

end:
    LDR R5,=0xFFFFFFFF
    STR R5, [R3, R4] @Armazeno o valor no array
    SWI 0x0

@Sub rotina de divisao
@R8 fica o resto
divisao:
    MOV  R8,R0 @ Divisor 
    MOV  R9,R2 @ Dividendo 
    
    CMP  R9, #0 @ comparo para ver se nao to dividindo por zero
    BEQ divisaoEnd 

    LDR  R10,=0 @ Resultado 
    LDR  R7,=1 @ Variavel que vai ficar

    BLS startDivisao  
                      
startDivisao:
    @ Loop para achar quantas vezes consigo multiplicar o dividendo por 2 ate ser maior que o divisor
    CMP      R9,R8 
    @ LS <=
    MOVLS    R9,R9,LSL#1 @ Dividendo x2
    MOVLS    R7,R7,LSL#1 @ Variavel que vai ficar diminuindo
    BLS      startDivisao

divisaoSecondLoop:
    @ Aqui o dividendo ja eh maior que o divisor
    CMP       R8,R9 
    @ CS >=
    SUBCS     R8,R8,R9   
    ADDCS     R10,R10,R7  
                        
    MOVS      R7,R7,LSR#1 
    
    @ CC <   
    MOVCC     R9,R9,LSR#1                  
    BCC       divisaoSecondLoop           
                           
divisaoEnd:
    MOV PC,LR  @volta para a funcao que realizou a chamada  

divide: 
    .word 0x0
    .word 0x0
    .word 0x0
    .word 0x0
    .word 0x0
    .word 0x0