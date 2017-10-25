		.section start
		.org 0
		jmp main
		.section directdata
		.org 4
res1:
		.space 2 		;reserva o espaço da variavel a 2 bytes neste cado o endereco 4 e 5
res2:
		.space 2 		;reserva o espaço da variavel a 2 bytes neste cado o endereco 6 e 7
res3:
		.space 2 		;reserva o espaço da variavel a 2 bytes neste cado o endereco 8 e 9
var1:
		.word 10
var2:
		.word 15
var3:
		.word 15
var4:
		.word 15
var5:
		.word 15
var6:
		.word 15
		.text 			; inicio de uma regiao de memoria para inico das instrucoes
		.org 0x0080
main:
		ld r0, var1
		ld r1, var2
		jmpl maior2
		st r0, res1
		
		ld r0, var3
		ld r1, var4
		jmpl maior2
		st r0, res2
		
		ld r0, var5
		ld r1, var6
		jmpl maior2
		st r0, res3
		jmp $
	
maior_arr:
		...
		jmp r5, #0
maior2:
		sub r6, r0, r1 	; r6 recebe flags; resultado aritemético é descartado
		jnc next
		orl r0, r1, r1,
next:
		jmo r5, #0
		.data			;
a1: 	.word 10, 15, 20, 12, 20
a2: 	.word 12, 16, 14, 18
	
	.end