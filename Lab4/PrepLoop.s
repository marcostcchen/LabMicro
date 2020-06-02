    .text
	.globl main

main:
    LDR R3, =0x8 @cte 8
    LDR R1, =0x0 @variavel i do loop
    B loop

loop:
    RSB offset_B, R1, #7  @ 7 - i
    LDR address_B, address_B, offset_B @ endB + 7 - i
    LDR value_B, [address_B] @ B[endB + 7 - i]

    LDR address_A, address_A, R1 @ endA + i
    STR value_B, [address_A] @ A[endA + i] = B[endB + 7 - i]

    CMP R1, #8 @ i == 8 ?
    ADD R1, #1 @ i++
    BNE loop @ i != 8

end: 
    SWI 0x0