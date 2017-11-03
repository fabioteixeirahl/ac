	.section start
	.org 0
	jmp main
	.section directdata
	.org 4
maior_arr_r2: .space 2
maior_arr_r3: .space 2	
maior_arr_r4: .space 2		
maior_arr_r5: .space 2 
res1: .space 2 		;reserva o espaço da variavel a 2 bytes neste cado o endereco 4 e 5
res2: .space 2 		;reserva o espaço da variavel a 2 bytes neste cado o endereco 6 e 7

	
	.text 			; inicio de uma regiao de memoria para inico das instrucoes
	.org 0x0080
main:
	ldi r0, #low(a1) 
	ldih r0, #high(a1)
	ldi r1, #5
	jmpl maior_arr
	st r0, res1
	
	ldi r0, #low(a2) 
	ldih r0, #high(a2)
	ldi r1, #4
	jmpl maior_arr
	st r0, res2
	
	jmp $
	
maior_arr:
	st r5, maior_arr_r5
	
	st r2, maior_arr_r2
	st r3, maior_arr_r3
	st r4, maior_arr_r4
	orl r2, r0, r0
	orl r3, r1,r1
	ld r0, [r2, #0]
	ldi r4, #1
	
for:	
	sub r6, r4, r3
	jz forend
	orl r1, r0,r0
	ld r0, [r2, r4]
	jmpl maior2
	add r4, r4, #1
	jmp for
forend:
	ld r5, maior_arr_r5
	ld r2, maior_arr_r2
	ld r3, maior_arr_r3
	ld r4, maior_arr_r4
	jmp r5, #0
maior2:
	sub r6, r0, r1 	; r6 recebe flags; resultado aritemético é descartado
	jnc next
	orl r0, r1, r1
next:
	jmp r5, #0
	.data			;
a1:.word 10, 15, 20, 12, 20
a2:.word 12, 16, 14, 18
	
	.end