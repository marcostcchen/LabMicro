.text
	.globl main
	
main:                 
    LDR r3,=3 @valor de b 
    LDR r4,=4 @valor de c   
    LDR r5,=5 @valor de d   
    BL func1 @branch to subroutine
    B end

func1: 
    MUL r6, r3, r4
    ADD r1, r6, r5
    MOV pc, r14 @return to main

end: 
    SWI 0x0