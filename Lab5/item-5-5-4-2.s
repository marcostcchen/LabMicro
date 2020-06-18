.text
	.globl main
	
main:        
    LDR r1, =0x5555AAAA @valor do input de X
    LDR r8, =0x5 @valor da sequencia Y
    LDR r9, =0x3 @r9 valor do inteiro n comprimento de Y
    MOV r11, r9
    LDR r2, =0 @r2 valor de saida 
    LDR r7, =0 @auxiliar do loopIgual 
    MOV r3, r1 @r3 auxiliar com valor do input
    MOV r4, r8 @r4 auxiliar com valor de Y
    LDR r10, =31 
    LDR r12, =32
    B loopPrincipal

loopPrincipal: 
    CMP r10, #-1 @ve se X acabou
    BEQ end

    MOV r5, r4, LSR r11 @vou analizar o bit i significativo de Y
    MOV r6, r3, LSR #31 @vou analizar o bit mais significativo de X

    @Atualiza valores dos aux
    SUB r10, r10, #1 

    @Loops de comparacao
    CMP r5, r6
    BEQ loopIguais  
    BNE naoIguais

naoIguais:
    LDR r7, =0
    MOV r3, r3, LSL #1
    MOV r11, r9 @ restart no indice de y
    B loopPrincipal 

loopIguais:
    SUB r11, r11, #1 @ passa para proximo valor de Y 
    ADD r7, r7, #1 @ adiciona 1 passo do loop
    CMP r7, r9 @compara com r9
    LDR r12, =32
    SUB r12, r12, r11
    MOV r4, r4, LSL r12
    MOV r4, r4, LSR r12
    BEQ achouSequencia
    BNE loopPrincipal

achouSequencia: 
    SUBS r7, r7, #1 @diminui o passo
    MOV r2, r2, LSL #1
    BNE achouSequencia
    ADD r2, r2, #1 @adiciona 1 na saida
    MOV r2, r2, LSL #1
    MOV r11, r9 @ restart no indice de y
    B loopPrincipal 

end: 
    SWI 0x0
