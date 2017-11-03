;	Exemplo elementar de construção de um pequeno programa.
;	São definidas as regiões de memória essenciais para estrururar:
;		- O arranque do programa após reset (.section start);
; 		- O alojamento de variáveis acessíveis por endereçamento direto (.section directdata);
;		- O programa (.text).
;	Neste exemplo o programa está todo contido na sequência identificada pela label "main"; não 
;	se usa o conceito de função.

	.section start
	.org 0
	jmp main

	.section directdata
	.org 4
res:
	.space 2
var1:
	.word 10
var2:
	.word 15
	
	.text
	.org 0x0080
	
;	Identidicar o maior valor de duas variáveis, var1 e var2, depositando-o na variável res.

main:
	ld r0, var1
	ld r1, var2
	sub r6, r0, r1	; r6 recebe flags; resultado aritmetico é descartado
	jnc next		; se r0 < r1, cy = 1.
	orl r0, r1, r1
next:
	st r0, res

	jmp $
	
	.end
