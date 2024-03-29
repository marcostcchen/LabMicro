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
	LDR sp, =stack_top
	BL c_entry
	.word 0xffffffff
	B .

Undefined_Handler:
	LDR sp, =stack_top
	BL undefined
	B .