@Crivo de 
.text
	.globl main

main:

        LDR r0,=9801 @valor limite
        BL sqrt @Coloca em r0 o valor do sqrt de r0


        SWI 0x0


@       Calculo da raiz 32 bits de R0
@       resultado em R0 in R0, usa R1 e R2

sqrt:
        MOV     r1,#0
        CMP     r1,r0,LSR #8
        BEQ     bit8            @ 0x000000xx numbers

        CMP     r1,r0,LSR #16
        BEQ     bit16           @ 0x0000xxxx numbers

        CMP     r1,r0,LSR #24
        BEQ     bit24           @ 0x00xxxxxx numbers

        SUBS    r2,r0,#0x40000000
        MOVCS   r0,r2
        MOVCS   r1,#0x10000

        ADD     r2,r1,#0x4000
        SUBS    r2,r0,r2,LSL#14
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x8000

        ADD     r2,r1,#0x2000
        SUBS    r2,r0,r2,LSL#13
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x4000
        MOV PC,LR

bit24:
        ADD     r2,r1,#0x1000
        SUBS    r2,r0,r2,LSL#12
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x2000

        ADD     r2,r1,#0x800
        SUBS    r2,r0,r2,LSL#11
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x1000

        ADD     r2,r1,#0x400
        SUBS    r2,r0,r2,LSL#10
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x800

        ADD     r2,r1,#0x200
        SUBS    r2,r0,r2,LSL#9
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x400
        MOV PC,LR

bit16:
        ADD     r2,r1,#0x100
        SUBS    r2,r0,r2,LSL#8
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x200

        ADD     r2,r1,#0x80
        SUBS    r2,r0,r2,LSL#7
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x100

        ADD     r2,r1,#0x40
        SUBS    r2,r0,r2,LSL#6
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x80

        ADD     r2,r1,#0x20
        SUBS    r2,r0,r2,LSL#5
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x40
        MOV PC,LR

bit8:
        ADD     r2,r1,#0x10
        SUBS    r2,r0,r2,LSL#4
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x20

        ADD     r2,r1,#0x8
        SUBS    r2,r0,r2,LSL#3
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x10

        ADD     r2,r1,#0x4
        SUBS    r2,r0,r2,LSL#2
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x8

        ADD     r2,r1,#0x2
        SUBS    r2,r0,r2,LSL#1
        MOVCS   r0,r2
        ADDCS   r1,r1,#0x4

        ADD     r2,r1,#0x1
        CMP     r0,r2
        ADDCS   r1,r1,#0x2

        MOV     r0,r1,LSR#1    
        MOV PC,LR
        
