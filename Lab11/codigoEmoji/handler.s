        .global handler_timer
        .text
        
handler_timer:
        LDR     r0,     TIMER0X
        MOV     r1,     #0x0
        STR     r1,     [r0] @Escreve no registrador TIMER0X para limpar o pedido de
        MOV     PC,     LR
