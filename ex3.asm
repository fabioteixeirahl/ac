; Exemplo adaptado do anterior.
; Além da exestência de funções, é introduzido o conceito de chamada encadeada:
;	- havendo uma função que chama outra, há a necessidade de preservar, pelo menos o registo r5;
;	- havendo maior ocupação de registos, raliza-se a sua preservação de acordo com a convenção
;	  (preservar os registos que não são recebidos como parâmetros).
; É criada a função "maior_arr" que chama "maior2".
; São realizadas, no programa "main", duas chamadas com parâmetros diferentes, usando dois arrays.
; São declarados, na região ".data", os dois arrays para usar nas chamadas à função.
;


	.section start
	.org 0
	jmp main

	.section directdata
	.org 4
	
; variáveis para preservação de registos em memória, no contexto da função maior_arr

maior_arr_r2: .space 2
maior_arr_r3: .space 2
maior_arr_r4: .space 2
maior_arr_r5: .space 2

; variáveis do programa main

res1:
	.space 2
res2:
	.space 2
	
	.text
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
	
;	
;	uint16 maior_arr( uint16 a[], uint16 n ){
;		uint16 i, res;
;		for( i = 0; i != n; ++i )
;			res = maior2( a[i], res );	
;		return res;
;	}
;
;	Inicio: r0 = a; r1 = n
;	Ciclo: r2 = a; r3 = n; r4 = i; r0 = res / r0 e r1 = parametros para chamar maior2()
;
	
maior_arr:
	st r5, maior_arr_r5
	
	st r2, maior_arr_r2
	st r3, maior_arr_r3
	st r4, maior_arr_r4
	
	orl r2, r0, r0	; a
	orl r3, r1, r1	; n
	ld r0, [r2, #0]	; res = a[0];
	ldi r4, #1		; i = 1;
for:
	sub r6, r4, r3	; i != n ?
	jz forend
	orl r1, r0, r0	; 2.º parametro
	ld r0, [r2, r4]	; 1.º parametro
	jmpl maior2		; resultado em r0
	add r4, r4, #1	; ++i;
	jmp for
forend:
	ld r2, maior_arr_r2
	ld r3, maior_arr_r3
	ld r4, maior_arr_r4
	
	ld r5, maior_arr_r5
	jmp r5, #0
	
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
	
	.data
a1:	.word 10, 15, 20, 12, 30
a2: .word 12, 16, 14, 18

b1: .space 18

	.end
