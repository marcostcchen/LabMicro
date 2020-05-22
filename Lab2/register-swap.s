.text
	.globl main
main: 
	LDR r1, =0xF631024C
	LDR r2, =0x17538ABD
	EOR r1, r1, r2
	EOR r2, r2, r1
	EOR r1, r1, r2
	SWI 0x0
