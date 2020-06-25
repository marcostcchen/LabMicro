.text
	.globl main
	
main:          
    LDR r3,=3 @valor de b 
    LDR r4,=4 @valor de c   
    LDR r5,=5 @valor de d   
    STMFD r13!, {r3-r5} @push into a full ascending stack
    BL func1 @branch to subroutine
    SWI 0x0

func1: 
    LDMFD r13!, {r3-r5}
    STMFD r13!, {r14} @push address to stack
    STMFD r13!, {r3-r5} @push into a full ascending stack
    BL func2 @subrotina que irá alterar os valores dos registradores
    LDMFD r13!, {r14}
    MOV pc, r14
    
func2: 
    LDMFD r13!, {r3-r5}
    MUL r6, r3, r4
    ADD r1, r6, r5
    MOV pc, r14 @return to func1
