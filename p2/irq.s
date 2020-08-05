.global _start
.text

_start:
  b _Reset                            @posição 0x00 -Reset
  ldr pc, _undefined_instruction      @posição 0x04 -Intrução não-definida
  ldr pc, _software_interrupt         @posição 0x08 -Interrupção de Software
  ldr pc, _prefetch_abort             @posição 0x0C -Prefetch Abort
  ldr pc, _data_abort                 @posição 0x10 -Data Abort
  ldr pc, _not_used                   @posição 0x14 -Não utilizado
  ldr pc, _irq                        @posição 0x18 -Interrupção (IRQ)
  ldr pc, _fiq                        @posição 0x1C -Interrupção(FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq

INTPND:     .word 0x10140000        @Interrupt status register
INTSEL:     .word 0x1014000C        @interrupt select register( 0 = irq, 1 = fiq)
INTEN:      .word 0x10140010        @interrupt enable register
TIMER0L:    .word 0x101E2000        @Timer 0 load register
TIMER0V:    .word 0x101E2004        @Timer 0 value registers
TIMER0C:    .word 0x101E2008        @timer 0 control register
TIMER0X:    .word 0x101E200c        @timer 0 interrupt clear register

_Reset:
  LDR sp, =svc_stack_top

  MRS r0, cpsr                         @ salvando o modo corrente em R0
  MSR cpsr_ctl, #0b11010010              @ alterando o modo para interrupt - o SP eh automaticamente chaveado ao chavear o modo
  LDR sp, =interrupt_stack_top             @ a pilha de undefined eh setada
  MSR cpsr, r0                           @ volta para o modo anterior

  bl  main
  b   .

undefined_instruction:
  b   .

software_interrupt:
  b   do_software_interrupt         @vai para o handler de interrupções de software

prefetch_abort:
  b   .

data_abort:
  b   .

not_used:
  b   .

irq:
  b   do_irq_interrupt              @vai para o handler de interrupções IRQ

fiq:
  b   .

do_software_interrupt:              @Rotina de Interrupçãode software
  add r1, r2, r3@r1 = r2 + r3
  mov pc, r14                       @volta p/ o endereço armazenado em r14

@Rotina de interrupções IRQ
do_irq_interrupt: @Rotina de interrupções IRQ
  @Empilho primeiro na estrutura auxiliar e dps salvo na estrutura correspondente
  @ {r0-r12, LR/sup, SP/sup, PC/sup, CPSR}
  SUB LR, LR, #4
  STMFD sp!, {r12}                  @salvo o R12 na pilha para liberar espaço
  LDR r12, =linhaAux                @coloco o endereco de de linhaA em R12
  STM r12, {r0-r11}                 @guardo os r0 a r11 na no endereco de linha A
  MOV r0, r12                       @coloco o endereco do linhaA no R0
  LDMFD sp!,{R12}                   @desempilho o antigo valor do r12 no proprio r12
  STR r12,[R0, #48]                 @salvo o R12 deslocado 48 bytes

  MRS r1, SPSR                      @pega o valor do cpsr do supervisor
  STR r1,[R0, #64]                  @salvando o CPSR do supervisor
  MOV r1, lr                        @pega o pc do supervisor
  STR r1,[R0, #60]                  @salva o pc do supervisor
  
  MRS r2, cpsr                      @ salvando o modo corrente em R2
  MSR cpsr_ctl, #0b11010011         @ alterando o modo para supervisor o SP eh automaticamente chaveado ao chavear o modo
  LDR r0, =linhaAux                 
  MOV r1, sp                        @stack pointer do supervisor
  STR r1,[r0, #56]
  MOV r1, lr                        @lr do supervisor
  STR r1,[r0, #52]
  MSR cpsr, r2                      @ volta para o modo anterior

  @ ---------------------------Vejo se o anterior é processo A ou B-------------------------
  LDR r0, nproc
  cmp r0, #0
  BEQ ArmazenaEmA
  B   ArmazenaEmB

  @----------------------------Empilha na linha correspondente------------------------------
ArmazenaEmA:
  LDR r12, =linhaAux                @ pego o endereco de aux
  LDMIA R12, {R0-R11}               @ carrego os r0 a r11
  LDR R12, = linhaA                 @ pego o endere'co de linhaA
  STMIA R12!,{R0-R11}               @ salvo em linhaA os valores de r0 a r11
  LDR R0, =linhaAux + 48            @ pego endereco dps de do r11
  LDMIA R0, {R1-R5}                 @ carrego o r12 sp lr pc e cpsr
  STMIA R12, {R1-R5}                @ salvo os valores carregados em r0 a r5 no r12 alterado
  B Fim_salva

ArmazenaEmB:
  LDR r12, =linhaAux                @ pego o endereco de aux
  LDMIA R12, {R0-R11}               @ carrego os r0 a r11
  LDR R12, = linhaB                 @ pego o endere'co de linhaB
  STMIA R12!,{R0-R11}               @ salvo em linhaA os valores de r0 a r11
  LDR R0, =linhaAux + 48            @ pego endereco dps de do r11
  LDMIA R0, {R1-R5}                 @ carrego o r12 sp lr pc e cpsr
  STMIA R12, {R1-R5}                @ salvo os valores carregados em r0 a r5 no r12 alterado

Fim_salva:
  LDR r0, INTPND @Carrega o registrador de status de interrupção
  LDR r0, [r0]
  TST r0, #0x0010 @verifica se é uma interupção de timer
  BLNE handler_timer @vai para o rotina de tratamento da interupção de timer
  @LDMFD sp!,{R0-R12,pc}^

handler_timer:
  LDR r0, TIMER0X
  MOV r1, #0x0
  STR r1, [r0] @Escreve no registrador TIMER0X para limpar o pedido de interrupção
  STMFD sp!, {LR}
  BL imprimeHash

@---------------------------------carrego os outros valores-----------------------
@ ---------------------------Vejo se eh a ou b e carrego -------------------------
  LDR r0, nproc
  cmp r0, #0
  BEQ CarregaB
  B   CarregaA

CarregaA:
  LDR R0, =nproc
  LDR R1, =0
  STR R1, [R0]
  LDR R0, =linhaA + 64
  MSR cpsr, R0
  LDR R0, =linhaA
  LDMIA R0, {R0-R15} @Carrego os outros valores e ja volta
  LDMFD sp!,{pc}

CarregaB:
  LDR R0, =nproc
  LDR R1, =1
  STR R1, [R0]
  LDR R0, =linhaB + 64 @Carrego o endereco do cpsr
  MSR cpsr, R0 @Vou para o modo do processo
  LDR R0, =linhaB
  LDMIA R0, {R0-R15} @Carrego os outros valores e ja volta
  LDMFD sp!,{pc} @Vou para o processoB

timer_init:
  LDR r0, INTEN
  LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
  STR r1,[r0]
  LDR r0, TIMER0L
  LDR r1, =0x0100000 @setting timer value
  STR r1,[r0]
  LDR r0, TIMER0C
  MOV r1, #0xE0 @enable timer module
  STR r1, [r0]
  mrs r0, cpsr 
  bic r0,r0,#0x80
  msr cpsr_c,r0 @enabling interrupts in the cpsr
  mov pc, lr

main:
  BL hello_word
  bl timer_init                     @initialize interrupts and timer 0
  b ProcessoA


ProcessoA:
	bl imprime1
  b ProcessoA

ProcessoB:
	bl imprime2
  b ProcessoB

linhaA:
  .word 0 @r0
  .word 0 @r1
  .word 0 @r2
  .word 0 @r3
  .word 0 @r4
  .word 0 @r5
  .word 0 @r6
  .word 0 @r7
  .word 0 @r8
  .word 0 @r9
  .word 0 @r10
  .word 0 @r11
  .word 0 @r12
  .word 0 @SP
  .word 0 @LR
  .word 0 @PC
  .word 0 @CPSR

linhaB:
  .word 1 @r0
  .word 2 @r1
  .word 3 @r2
  .word 4 @r3
  .word 5 @r4
  .word 6 @r5
  .word 7 @r6
  .word 8 @r7
  .word 9 @r8
  .word 10 @r9
  .word 11 @r10
  .word 12 @r11
  .word 13 @r12
  .word stack_taskB @SP
  .word 0 @LR
  .word ProcessoB @PC
  .word 0x20000153 @CPSR

linhaAux: @Regiao para guardar os valores temporariamente
  .skip 68

nproc:
  .word 0
