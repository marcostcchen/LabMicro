.text
	.globl main
	
main:        
    LDR r2,=vetor @r2 endereco do primeiro valor do vetor
    BL func1 @branch to subroutine
    B end

func1: 
    LDMIA r2, {r3-r5}
    MUL r6, r3, r4
    ADD r1, r6, r5
    MOV pc, r14 @return to main
end: 
    SWI 0x0

vetor: 
    .word 2,3,4 @valores de a,b,c,d respectivamente