.text
	.globl main
	
main:        
    LDR r1, =0xB6 @r1 Initial input X
    LDR r2, =0 @r2 valor de saida 
    MOV r3, r1 @r3 auxiliar com valor de r1 
    LDR r8, =0 @r8 valor de Y
    LDR r5, =32 @Auxiliar de contagem
    B EstadoA

EstadoA:
    CMP r5, #0
    BEQ end
    MOVS r4, r3, LSR #31 @r4 vai ser o bit que vou analisar
    MOV r3, r3, LSL #1 @atualizo valor de r3
    MOV r2, r2, LSL #1 @shift left the value of Y
    SUB r5, r5, #1
    BEQ EstadoA @se r4 for zero
    BNE EstadoB @se r4 nao for um

EstadoB:
    CMP r5, #0
    BEQ end
    MOVS r4, r3, LSR #31 @ pego o segundo mais significativo
    MOV r3, r3, LSL #1 @atualizo valor de r3
    MOV r2, r2, LSL #1 @shift left the value of Y
    SUB r5, r5, #1
    BEQ EstadoC @se r4 for zero
    BNE EstadoB @se r4 nao for um

EstadoC:
    CMP r5, #0
    BEQ end
    MOVS r4, r3, LSR #31 @ pego o segundo mais significativo
    MOV r3, r3, LSL #1 @atualizo valor de r3
    MOV r2, r2, LSL #1 @shift left the value of Y
    SUB r5, r5, #1
    BEQ EstadoA @se r4 for zero
    BNE EstadoD @se r4 nao for um

EstadoD:
    CMP r5, #0
    BEQ end
    MOVS r4, r3, LSR #31 @ pego o segundo mais significativo
    MOV r3, r3, LSL #1 @atualizo valor de r3
    MOV r2, r2, LSL #1 @shift left the value of Y
    SUB r5, r5, #1
    BEQ EstadoA @se r4 for zero
    BNE EstadoE @se r4 for um

EstadoE:
    CMP r5, #0
    BEQ end
    MOVS r4, r3, LSR #31 @ pego o segundo mais significativo
    MOV r3, r3, LSL #1 @atualizo valor de r3
    ADD r2, r2, #1 @add 1 
    MOV r2, r2, LSL #1 @shift left the value of Y
    SUB r5, r5, #1
    BEQ EstadoC @se r4 for zero
    BNE EstadoB @se r4 nao for um

end: 
    SWI 0x0
