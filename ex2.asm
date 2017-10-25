;int res;
;int var1;
;int var2;
;ires=var1;
;if(res < var2)
;res=var2;

	.section start
	.org 0
	jmp main
	
	.section directdata
	.org 4
res:
	.space 2 ;reserva o espaço da variavel a 2 bytes neste cado o endereco 4 e 5
var1:
	.word 10
var2:
	.word 15
	
	.text ; inicio de uma regiao de memoria para inico das instrucoes
	.org 0x0080
main:
	ld r0, 6
	ld r1, 8
	sub r6, r0, r1 ; r6 recebe flags; resultador aritmetico e descartado
	jnc next
	orl r0, r1, r1
next:
	st r0, res
	jmp $
	.end
