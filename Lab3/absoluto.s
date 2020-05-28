.text
	.globl	main
main:
	MOV	r0, #4
	CMP	r0, #0
	RSBLT	r0, r0, #0
	MOV	r1, r0
	SWI	0x0