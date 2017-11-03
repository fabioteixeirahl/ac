; Exemplo adaptado do anterior. É introduzido o conceito de função.
; É criada a função "maior2" para selecionar o maior dos dois parâmetros
; São realizadas, no programa "main", várias chamadas com parâmetros diferentes.
;
	.section start
	.org 0
	jmp main

	.section directdata
	.org 4
res1:
	.space 2
res2:
	.space 2
res3:
	.space 2

var1:
	.word 10
var2:
	.word 15
var3:
	.word 12
var4:
	.word 9
var5:
	.word 5
var6:
	.word 5
	
	.text
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
	
;
;	uint16 maior2( uint16 a, uint16 b ){
;		if( a < b )
;			a = b;
;		return a;
;	}
;

maior2:
	sub r6, r0, r1	; r6 recebe flags; resultado aritmetico é descartado
	jnc next
	orl r0, r1, r1
next:
	jmp r5,#0
	
	.end
