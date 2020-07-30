.global _start
.text
_start:
    b _Reset @posição 0x00 -Reset
    ldr pc, _undefined_instruction @posição 0x04 -Intrução não-definida
    ldr pc, _software_interrupt @posição 0x08 -Interrupção de Software
    ldr pc, _prefetch_abort @posição 0x0C -Prefetch Abort
    ldr pc, _data_abort @posição 0x10 -Data Abort
    ldr pc, _not_used @posição 0x14 -Não utilizado
    ldr pc, _irq @posição 0x18 -Interrupção (IRQ)
    ldr pc, _fiq @posição 0x1C -Interrupção(FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq

INTPND:.word 0x10140000 @Interrupt status register
INTSEL:.word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN:.word 0x10140010 @interrupt enable register
TIMER0L:.word 0x101E2000 @Timer 0 load register
TIMER0V:.word 0x101E2004 @Timer 0 value registers
TIMER0C:.word 0x101E2008 @timer 0 control register

_Reset:
	LDR sp, =svc_stack_top

    MRS r0, cpsr @ salvando o modo corrente em R0
    MSR cpsr_ctl, #0b11010010 @ alterando o modo para IRQ - o SP eh automaticamente chaveado ao chavear o modo
    LDR sp, =irq_stack_top @ a pilha de IRQ eh setada 
    MSR cpsr, r0 @ volta para o modo anterior 

    bl  main
    b   .

undefined_instruction:
    b   .

software_interrupt:
    b   do_software_interrupt @vai para o handler de interrupções de software

prefetch_abort:
    b   .

data_abort:
    b   .

not_used:
    b   .

irq:
    b   do_irq_interrupt @vai para o handler de interrupções IRQ

fiq:
    b   .

@Rotina de Interrupçãode software
do_software_interrupt:
    add r1, r2, r3  @r1 = r2 + r3
    mov pc, r14 @volta p/ o endereço armazenado em r14
    
@Rotina de interrupções IRQ    
do_irq_interrupt: @Rotina de interrupções IRQ
   @Salvar os registradores em linhaA
   SUB LR, LR, #0x4
   STMFD sp!, {r0-r12, lr} @Empilha os registradores

   LDR r0, =1 
   LDR r1, =2 
   LDR r2, =3 
   LDR r3, =4 
   LDR r4, =5 
   LDR r6, =7 
   LDR r7, =1 
   LDR r8, =2 
   LDR r9, =3 
   LDR r10, =4 
   LDR r11, =5 
   LDR r12, =100 

   @Funcao para armazenar os registradores do processoA guardando no formato {r0-r12, PC, CPSR, LR, SP}
   STMFD sp!, {r12} @empilha R0
   LDR r12, =linhaA
   STM r12, {r0-r11}@Guardo os valores do processoA dos regs r1 a r12
   LDMFD sp!, {r2} @pega o valor antigo de r12 
   STR r2, [r12, #48]

   @Agr subir os registradores LR, CPSR, SP, PC, 
   @PC/supervisor
   LDR r2, [sp, #52] @Pego o valor de lr armazenado
   STR r2, [r12, #52] @subo o valor de PC original que é LR - 4 que estava salvo já na pilha
   
   @CPSR
   MRS r4, spsr @pego valor do CPSR/supervisor
   STR r4, [r12, #56] @guardo em linha A

   @LR e SP
   MRS R1, CPSR @Armazena o modo atual irq
   MRS R2, SPSR 
   MSR CPSR, R2 @vai para o modo supervisor
   STR LR, [r12, #60] @Guarda o LR do modo supervisor
   STR SP, [r12, #64] @Guarda o SP do modo supervisor
   MSR CPSR, R1 @Volta para o modo atual irq

   @ Troca tudo
   LDR r0, =11
   LDR r1, =12 
   LDR r2, =13 
   LDR r3, =14 
   LDR r4, =15 
   LDR r6, =16 
   
   @Recuperar {r0-r12, PC, CPSR, LR, SP }
   LDR r12, =linhaA
   SUB r12, r12, #92 @pega o primeiro item do vetor
   MRS R1, CPSR @Armazena o modo atual irq
   MRS R2, SPSR 
   MSR CPSR, R2 @vai para o modo supervisor
   LDMFD r12!, {LR,SP} @Guarda o LR e SP do modo supervisor
   LDMFD r12!, {r11} @pego o CPSR supervisor
   MSR CPSR, R11 @atualizo o valor do CPSR anterior
   MSR CPSR, R1 @Volta para o modo atual irq
   LDMFD r12!, {r0, r0-r12}^


   @Loop para copiar os dados que estao no SP
   LDR r0, INTPND @Carrega o registrador de status de interrupção 
   LDR r0, [r0]
   TST r0, #0x0010 @verifica se é uma interupção de timer
   BLNE handler @vai para o rotina de tratamento da interupção de timer
   LDMFD sp!,{R0-R12,pc}


timer_init:
 mrs r0, cpsr
 bic r0,r0,#0x80
 msr cpsr_c,r0 @enabling interrupts in the cpsr
 LDR r0, INTEN
 LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
 STR r1,[r0]
 LDR r0, TIMER0C
 LDR r1, [r0]
 MOV r1, #0xA0 @enable timer module
 STR r1, [r0]
 LDR r0, TIMER0V
 MOV r1, #0xff @setting timer value
 STR r1,[r0]
 mov pc, lr

main:
    bl timer_init @initialize interrupts and timer 0

stop:
    bl printSpaces @printa espaços
    b stop

