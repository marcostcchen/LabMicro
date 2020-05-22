.text
	.global main
main:


    #//Multiplicou por 4 
	LDR r4,=0x00000002
    MOV r1, r4, LSL #2

    #//Multiplicou por 5
	LDR r4,=0x00000002
    MOV r1, r4, LSL #2
    ADDS r2, r1, r4

    #//Multiplicou por 3
	LDR r4,=0x00000002
    MOV r1, r4, LSL #2
    SUBS r2, r1, r4

    #//Multiplicou por 15
	#//Multiplica por 3 primeiro r2 output
    LDR r4,=0x00000002
    MOV r1, r4, LSL #2
    SUBS r2, r1, r4
    #//Multiplica por 5 depois r3 output
    MOV r1, r2, LSL #2
    ADDS r3, r1, r2


    SWI 0x0
