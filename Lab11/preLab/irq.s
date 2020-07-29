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
   
   @ Valores fixos para os registradores apenas para visualizar se 
   @ a memória de linhaA está armazenando os registradores corretamente
   LDR r0, =1 @ Teste
   LDR r1, =2 @ Teste
   LDR r2, =3 @ Teste
   LDR r3, =4 @ Teste
   LDR r4, =5 @ Teste
   LDR r5, =6 @ Teste
   LDR r6, =7 @ Teste
   LDR r7, =1 @ Teste
   LDR r8, =2 @ Teste
   LDR r9, =3 @ Teste
   LDR r10, =4 @ Teste
   LDR r11, =5 @ Teste
   LDR r12, =6 @ Teste

   STMFD sp!, {r0-r12, PC} @Guarda os valores do modo supervisor no stack

   @Funcao para armazenar os registradores do processoA
   LDR r0, =linhaA @minha pilha para o processoA
   STMFD r0!, {r1-r12}@Guardo os valores do processoA dos regs r1 a r12
   LDR r1, [sp] @Quero pegar o valor de r0
   STMFD r0!, {r1} @subo o valor de r0 que faltou, no endereco de linhaA terei os valores dos regs de r0 a r12

   @Loop para copiar os dados que estao no SP

   LDR r0, INTPND @Carrega o registrador de status de interrupção 
   LDR r0, [r0]
   TST r0, #0x0010 @verifica se é uma interupção de timer
   BLNE handler @vai para o rotina de tratamento da interupção de timer
   LDMFD sp!,{R0-R12,pc}^


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

