.text
	.globl main
main:
      MOV    r0, #0x0
      LDR    r3, =vetor
      
      MOV    r6, #0x7		
      #Tamanho do vetor
      MOV    r7, #0x0		
      #i
      MOV    r8, #0x7		
      #passvetor
      SUB    r8, r8, #0x1
      MOV    r9, #0x0

loop_externo:
      CMP r9,r8
      BPL    fim
          
loop_interno:
      CMP    r7 ,r8
      BPL    subtracao_pass
     
      MOV    r4 , r3
      LDMIA  r3!, {r1}
      MOV    r5 , r3 
      LDMIA  r3, {r2}
      
      ADD r7,r7,#0x1		
      # i = i + 1
      
      B compare
      
subtracao_pass:
	SUB r8,r8,#0x1
        MOV    r7, #0x0
        LDR    r3, =vetor	 
	B loop_externo
      
fim:

      SWI 0x0
      
compare:
      CMP    r2 ,r1
      BMI    troca
      B      loop_interno
      
troca:
      STR    r1, [r5]
      STR    r2, [r4]
      B      loop_interno	

vetor:
     .word 5,2,3,8,1,6,4,7
