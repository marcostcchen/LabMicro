.text
	.global main
main:
    //O maximo permitido é somar valores de 8 bits 
	ADD r3,r7, #512
    
    //O maximo permitido para o LSL é 31 vezes, 32 ja estora o limite de bits
    SUB r11, r12, r3, LSL #31
    SWI 0x0