	.text
	.globl   int2str
			
@ R0 int inteiro, R1 char* pontstr 
int2str:              
    MOV r3, #10 @Dividendo
    MOV r5, #0 @Offset storage
    MOV r2, #1 @Loop counter
    ADD r1, r1, #8
    B loop

loop:
    B divisao @retorno o resto em r4

afterDivisao:
    @converte para ascii
    ADD r4, r4, #48

    @Armazena no array
    STRB r4, [r1], #-1

    @decrementa o loop counter
    ADDS r2, r2, #1
    CMP r2, #10
    BNE loop

end:
	mov	pc, lr          @ Return by branching to the address in the link register.

divisao:
    MOV  R8,R0 @ Divisor 
    MOV  R9,R3 @ Dividendo 
    
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
    MOV R4, R8
    MOV R0, R10
    B afterDivisao @volta para a funcao que realizou a chamada  
