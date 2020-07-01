.text
	.globl main

main:

    LDR  R1,=9833065 @ Divisor
    MOV  R2,#5 @ Dividendo
    
    CMP  R2, #0 @ comparo para ver se nao to dividindo por zero
    BEQ divide_end 

    MOV  R0,#0 @ Resultado   
    MOV  R3,#1 @ Variavel que vai ficar diminuindo

    BLS start  
                      
start:
    @ Loop para achar quantas vezes consigo multiplicar o dividendo por 2 ate ser maior que o divisor
    CMP      R2,R1 
    @ LS <=
    MOVLS    R2,R2,LSL#1 @ Dividendo x2
    MOVLS    R3,R3,LSL#1 @ Variavel que vai ficar diminuindo
    BLS      start

next:
    @ Aqui o dividendo ja eh maior que o divisor
    CMP       R1,R2 
    @ CS >=
    SUBCS     R1,R1,R2   
    ADDCS     R0,R0,R3  
                        
    MOVS      R3,R3,LSR#1 
    
    @ CC <   
    MOVCC     R2,R2,LSR#1                  
    BCC       next           
                           
divide_end:
    MOV       R6, R7      

@ Resultado final: R1 resto, R2 entrada do valor, R0 resultado, R3 zero