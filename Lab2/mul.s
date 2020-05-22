.text
	.globl main
main: 
	LDR r1,=0xFFFFFFFF
	LDR r2,=0x80000000
	MULS r4,r2,r1

