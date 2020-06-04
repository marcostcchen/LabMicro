.text
    .globl main
    
main:
    ldrb    r3, =0        @ Carrega o valor do inteiro 's' que servirá de offset do array
    adr    r1, array    @ Carrega o endereço inicial do array em r1
    
init_Pointers:
    adr    r2, array      @ Carrega o endereço inicial do array
    add     r3,r2,r0       @ carrega r3 com a soma do endereço incial mais o offset
    ldrb     r4, =0         @ Carrega a constante 0 para carregar

loop2:
    CMP     r3, r2        @ Compara r3, r2 para ver se r2 passou do resultado
       BMI     final          @ Termina o Loop se r3,r2 é uma relação negativa
       
       strb     r4, [r2], #1   @ Carrega a constante 0 na posição do array
    b     loop2        @ retorna ao loop
    
final:
    SWI 0x0
    
array:
 .byte 0,1,2,3,4,5,6,7