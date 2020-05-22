.text
	.globl main
main: 
	LDR r1,=0x00000000
	LDR r2,=0x00000015
	ADD r2,r0,r1,LSL #5
	SWI 0x0
