.text
	.globl main
	
main:        
    MOV r6,#0xA          @ load 10 into r6
    MOV r4,r6            @ copy n into a temp register

loop:             
    SUBS    r4, r4, #1       @ decrement next multiplier
    MULNE   r1, r6, r4       @ perform multiply
    MOVNE   r6, r1           @ save off product for another loop
    BNE     loop             @ go again if not complete

end: 
    SWI 0x0
