.text
	.globl main
	
	
@ A matriz é colocada nos endereços de matriz e vetor no fim do código (a partir da linha 273).
@ O tamanho da matriz (N) é colocado nas linha 76, (N^2) nas linhas 19, 20, 77 e em 78 colocamos o valor de (N x 4)

@ O resultado sairá nos registradores r9 e r12. Se r9 for 0 a matriz é um quadrado mágico. Se for 1 a matriz não é
@ por conta de que uma das somas (linhas, colunas, diagonal) não bate, se for 2 não é quadrado mágico por conta
@ de existir um numero repetido. Se r12 for 0 todos os valores estão dentro do intervalo de 1 a N^2, se for 1 quer
@ dizer que ao menos 1 valor não está nesse intervalo. 
	
	
@bubble_sort
	bubble_sort: 
	      MOV    r0, #0x0
	      LDR    r3, =vetor
	      
	      MOV    r6, #16					@ TAMANHO DE N^2
	      MOV    r8, #16					@ TAMANHO DE N^2
	      	
	      MOV    r7, #0x0		
		
	      SUB    r8, r8, #0x1
	      MOV    r9, #0x0

	loop_externo:
	      CMP r9,r8
	      BPL    quadrado
		  
	loop_interno:
	      CMP    r7 ,r8
	      BPL    subtracao_pass
	     
	      MOV    r4 , r3
	      LDMIA  r3!, {r1}
	      MOV    r5 , r3 
	      LDMIA  r3, {r2}
	      
	      ADD r7,r7,#0x1		
	      
	      B compare
	      
	subtracao_pass:
		SUB r8,r8,#0x1
		MOV    r7, #0x0
		LDR    r3, =vetor	 
		B loop_externo
	      
	compare:
	      CMP    r2 ,r1
	      BMI    troca
	      B      loop_interno
	      
	troca:
	      STR    r1, [r5]
	      STR    r2, [r4]
	      B      loop_interno	



main:
	B bubble_sort


quadrado:
          LDR    r0, =matriz		@ Endereço da matriz
	  LDR    r1, =soma		@ Endereço da matriz que conterá soma das linhas, colunas e diagonal
	 
          MOV	 r2, #0x0		@ Var que le valor da matriz
	  MOV    r3, #0x0		@ Var que recebe uma soma de linhas, colunas ou diagona
	  
	  MOV    r4, #0x0		@ Contador de laço i
	  MOV    r5, #0x0		@ Contador de laço j
	  
	  MOV    r6, #4		@ N
	  MOV    r7, #16		@ N^2
	  MOV    r8, #16		@ N x 4 para trabalhar com word
	  MOV    r13, #4
	
	  MOV    r9,  #0x0		@ resultado, se =0x0 matriz é , se =0x1 não é 
	  MOV    r10, #0x1		@ constante 1
	  LDR    r11, =matriz		@ Endereço da matriz
	  MOV    r12, #0x0		@ Confirma se os valores estão entre N^2 e 1
	
	  B  loop_soma_linhas

fim:
       SWI 0x0

@Registra a soma de todas as linhas
	 loop_soma_linhas:
		CMP r5,r6
		BEQ fim_loop_soma_linhas
		ADD r5, r5, r10
		B soma_linha
	
	@Soma uma unica linha	
	soma_linha:				
		CMP r4,r6                      
		BEQ fim_soma_linha
		LDMIA  r0!, {r2}
		ADD r3,r3,r2
		ADD r4, r4, r10
		B soma_linha

	@ Registra soma de uma linha na matriz soma
	fim_soma_linha:
		STMIA r1!, {r3}
		MOV    r4, #0x0
		MOV    r3, #0x0
		B loop_soma_linhas
	
	@ Reinicia as variaveis a seus valores iniciais	
	fim_loop_soma_linhas:
		  MOV	 r2, #0x0
		  MOV    r5, #0x0 
		  MOV    r4, #0x0
		  LDR    r0, =matriz
		  B loop_soma_colunas
		  
@Registra a soma de todas as colunas
	loop_soma_colunas:
		CMP r5,r6
		BEQ fim_loop_soma_colunas
		ADD r5, r5, r10
		B soma_coluna
		
	soma_coluna:
		CMP r4,r6
		BEQ fim_soma_coluna
		LDMIA  r0, {r2}
		ADD r0, r0, r8
		ADD r3,r3,r2
		ADD r4, r4, r10
		B soma_coluna

	fim_soma_coluna:
		STMIA r1!, {r3}
		MOV    r4, #0x0
		MOV    r3, #0x0
		LDR    r0, =matriz
		ADD    r0, r0, r10
		B loop_soma_colunas
		
	fim_loop_soma_colunas:
		  MOV	 r2, #0x0
		  MOV    r5, #0x0
		  MOV    r4, #0x0
		  LDR    r0, =matriz
		  LDR    r1, =soma  
		  B soma_diagonal
		  
@Registra a soma das diagonais	  
	soma_diagonal:
		CMP r4,r6
		BEQ fim_soma_diagonal
		LDMIA  r0, {r2}
		ADD r0, r0, r8
		ADD r0, r0, r10
		ADD r3,r3,r2
		ADD r4, r4, r10
		B soma_diagonal

	fim_soma_diagonal:
		STMIA r1!, {r3}
		MOV    r4, #0x0
		MOV    r5, #0x0
		MOV    r3, #0x0
		LDR    r0, =matriz
		ADD    r0, r0, r10
		B compara_linhas
		
@compara se todas as somas sao iguais
	compara_linhas:
		LDMIA  r1!, {r2}
		CMP r4,r6
		BEQ compara_colunas
		LDMIA  r1!, {r3}
		CMP r2, r3
		BNE fim_nao_sendo_magico
		ADD r4, r4, r10
		
	compara_colunas:
		MOV    r4, #0x0
		CMP r4,r6
		BEQ compara_diagonal
		LDMIA  r1!, {r3}
		CMP r2, r3
		BNE fim_nao_sendo_magico
		ADD r4, r4, r10
		
	compara_diagonal:
		LDMIA  r1!, {r3}
		CMP r2, r3
		BNE fim_nao_sendo_magico
		
		@Reinicia variavéis
		MOV    r4, #0x4
		MOV    r5, #0x0
		MOV    r3, #0x0
		LDR    r0, =matriz
		ADD    r0, r0, r10
		
		
		LDR    r5, =matriz 
		ADD    r11,r11,r4
		MOV    r4, #0x0		
		B procura_nums_repetidos_loop_exterior
		
fim_nao_sendo_magico:
		MOV    r9,  #0x1
		B acha_intervalo
		
fim_nao_sendo_magico_num_repetido:
		MOV    r9,  #0x2
		B acha_intervalo

procura_nums_repetidos_loop_exterior:
		LDR    r11, =matriz
		MOV r6, #4
		MUL r5,r4,r6
		ADD r11,r11,r5
		ADD r11,r11,r6
		
		
		MOV r5, #0
		ADD r5, r5, r4
		ADD r5, r5, r10
		
		CMP r4,r7
		BEQ acha_intervalo
		LDMIA  r0!, {r2}
		ADD r4, r4, r10
		B procura_nums_repetidos_loop_interior

procura_nums_repetidos_loop_interior:			
		CMP r5,r7
		BEQ procura_nums_repetidos_loop_exterior
		LDMIA  r11!, {r3}
		CMP r2, r3
		BEQ fim_nao_sendo_magico_num_repetido
		ADD r5, r5, r10
		B procura_nums_repetidos_loop_interior
		
acha_intervalo:
		@Reinicia variavéis
		MOV    r4, #0x0
		MOV    r5, #0x0
		MOV    r3, #0x0
		LDR    r0, =matriz
			
		LDMIA  r0, {r2}
		MUL r11,  r8, r13
		ADD r0 , r0 , r11
		SUB r0 , r0 , r13
		LDMIA  r0, {r3}
		
		MOV r4, #0x1
		
		CMP r2,r4
		BMI fim_fora_intervalo
		CMP r7,r3
		BMI fim_fora_intervalo
		
		MOV r12, #0x0
		B fim
		
fim_fora_intervalo:
		MOV r12, #0x1
		B fim

matriz:
         .word 16,3,2,13
	 .word 5,10,11,8
	 .word 9,6,7,12
	 .word 4,15,14,1
	 
vetor:
         .word 16,3,2,13
	 .word 5,10,11,8
	 .word 9,6,7,12
	 .word 4,15,14,1
	 
soma:
	 .word 0,0,0,0
	 .word 0,0,0,0
	 .word 0,0,0,0
	 .word 0,0,0,0
	
