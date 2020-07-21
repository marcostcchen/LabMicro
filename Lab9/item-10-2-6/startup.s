@ Em um terminal com o docker aberto:
@ eabi-gcc c_entry.c -o c_entry.o
@ eabi-as startup.s -o startup.o
@ eabi-ld -T test.ld c_entry.o startup.o -o program.elf
@ eabi-bin program.elf program.bin
@ qemu program.bin
@
@ Depois, no outro terminal para rodar o gdb:
@ eabi-qemu -se program.elf
@

.section INTERRUPT_VECTOR, "x"
.global _Reset
_Reset:
 B Reset_Handler /* Reset */
 B Undefined_Handler /* Undefined */
 B . /* SWI */
 B . /* Prefetch Abort */
 B . /* Data Abort */
 B . /* reserved */
 B . /* IRQ */
 B . /* FIQ */
Reset_Handler:
 LDR sp, =svc_stack_top
 MRS r0, cpsr    		@ salvando o modo corrente em R0
 MSR cpsr_ctl, #0b11011011 	@ alterando o modo para undefined - o SP eh automaticamente chaveado ao chavear o modo
 LDR sp, =undefined_stack_top 	@ a pilha de undefined eh setada 
 MSR cpsr, r0 			@ volta para o modo anterior 
 .word 0xffffffff		@ vai para undefined handler
 BL c_entry
 B .
 
Undefined_Handler:
 STMFD sp!,{R0-R12,lr}
 BL undefined
 LDMFD sp!,{R0-R12,pc}^

