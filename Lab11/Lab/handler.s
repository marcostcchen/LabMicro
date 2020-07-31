.global handler_timer
.text

TIMER0X:.word 0x101E200c @timer 0 interrupt clear register

handler_timer:
    LDR r0, TIMER0X
    MOV r1, #0x0
    BL print_hash
    STR r1, [r0] @Escreve no registrador TIMER0X para limpar o pedido de interrupção
    
    @ Inserir código que seraexecutado na interrupção de timer aqui (chaveamento de processos,  ou alternar LED por exemplo)
    LDMFD sp!,{R0-R12,pc}^
    mov pc, r14 @retorna
