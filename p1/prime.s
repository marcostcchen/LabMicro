@ Funcao que retorna 1 se eh primo ou 0 se nao eh primo

.text
	.globl main

main:

 MOV R0,#15               @ valor de teste

 CMP R0,#01               @Comparar com 1
 BEQ ehPrimo              @If equal declare directly as prime

 CMP R0,#02               @Comparar com 2
 BEQ ehPrimo              @If equal declare directly as prime
 
 MOV R1,R0                @copiando valor de teste para r1
 MOV R2,#02               @divisor inicial vai ser o 2

loopCheckPrime:        @Loop de verificacao de i que vai de 0 ao valor do numero estudado para verificarmos se tem algum divisor                     
 
 BL divisao              @Sub rotina de divisao
 CMP R8,#0               @Compara se o resto eh zero
 BEQ naoPrimo             @Se for zero, entao temos um divisor, logo numero nao eh primo
 ADD R2,R2,#01            @Se nao for zero, acrescento o divisor de analise
 CMP R2,R1                
 BEQ ehPrimo                @All possible numbers are done means It's prime
 B loopCheckPrime

naoPrimo: 
 LDR R4,=0x0       @não é primo retorna 0
 B end

ehPrimo: 
 LDR R4,=0x1       @eh primo, retorna 1
 B end

end:
  SWI 0x0

@Sub rotina de divisao
divisao:
    MOV  R8,R0 @ Divisor antigo R1
    MOV  R9,R2 @ Dividendo antigo R2
    
    CMP  R9, #0 @ comparo para ver se nao to dividindo por zero
    BEQ divide_end 

    MOV  R10,#0 @ Resultado  antigo R0
    MOV  R7,#1 @ Variavel que vai ficar diminuindo antigo R3

    BLS startDivisao  
                      
startDivisao:
    @ Loop para achar quantas vezes consigo multiplicar o dividendo por 2 ate ser maior que o divisor
    CMP      R9,R8 
    @ LS <=
    MOVLS    R9,R9,LSL#1 @ Dividendo x2
    MOVLS    R7,R7,LSL#1 @ Variavel que vai ficar diminuindo
    BLS      divisaoSecondLoop

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
                           
divideEnd:
    MOV PC,LR  @volta para a funcao que realizou a chamada  
