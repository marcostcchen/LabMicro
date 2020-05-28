.text
	.globl main

main:
    	MOV	r0, #-4
    	MOV	r1, #4
	UMULL   r3, r4, r0, r1
	
	CMP	r0, #0
	CMPPL	r1, #0
	BPL	final
	
	CMP	r0, #0
	CMPMI	r1, #0
	BMI	final
	
	MOV	r3, #4
	CMP	r3, #0
	RSBLT	r3, r0, #0
	MOV	r5, r3
	
	MOV	r4, #4
	CMP	r4, #0
	RSBLT	r4, r0, #0
	MOV	r6, r4

final:
	SWI	0x0