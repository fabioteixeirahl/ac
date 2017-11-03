; Exemplo adaptado do anterior, adicionando mais um nível na cadeia de chamada:
;	main --> ordena --> maior_idx --> maior_que
;	                --> troca 
; É acriada a função ordena que chama maior_idx e que usa o índice obtido para, em sucessivas iterações, 
; ordenar o array.
; É também criada e chamada uma função "troca" que demonstra a utilização de uma quantidade 
; de parâmetros diferente.
;
	.section start
	.org 0
	jmp main

	.section directdata
	.org 4
	
; localizações para preservação de registos em memória, no contexto da função ordena

ordena_r2: .space 2
ordena_r3: .space 2
ordena_r4: .space 2
ordena_r5: .space 2

; localizações para preservação de registos em memória, no contexto da função troca

troca_r3: .space 2
troca_r4: .space 2

; localizações para preservação de registos em memória, e para variáveis locais
; no contexto da função maior_idx

maior_idx_r2: .space 2
maior_idx_r3: .space 2
maior_idx_r4: .space 2
maior_idx_r5: .space 2
maior_idx_res: .space 2

	
	.text
	.org 0x0080
main:
	ldi r0, #low(a1)
	ldih r0, #high(a1)
	ldi r1, #5
	jmpl ordena

	ldi r0, #low(a2)
	ldih r0, #high(a2)
	ldi r1, #4
	jmpl ordena
	
	jmp $
	
;	
;	uint16 ordena( uint16 a[], uint16 n ){
;		int i;
;		for( i = n-1 ; n != 0 ; --i ){
;			uint16 aux = maior_idx( a, i+1 );	
;			troca( a, aux, i );
;		}
;	}
;
;	Parâmetros: r0 = a; r1 = n
;	variáveis locais, durante o ciclo:
;		r4 = a; r3 = i;
;	ocupação de registos com parâmetros:
;		r0, r1	   - para chamar maior_idx()
;		r0, r1, r2 - para chamar troca()
;		

ordena:
	st r5, ordena_r5
	
	st r2, ordena_r2
	st r3, ordena_r3
	st r4, ordena_r4
	
	orl r4, r0, r0	; a

	sub r3, r1, #1	; i = n-1
for_ord:
	;sub r6, r3, #0	;  i != 0 ? - desnecessário comparar (vem sempre de sub ...)
	jz forend_ord
	orl r0, r4, r4	; a
	add r1, r3, #1	; i+1
	jmpl maior_idx
	 
	orl r2, r3, r3	; i
	orl r1, r0, r0	; aux
	orl r0, r4, r4	; a
	jmpl troca

	sub r3, r3, #1
	jmp for_ord
forend_ord:
	ld r2, ordena_r2
	ld r3, ordena_r3
	ld r4, ordena_r4
	
	ld r5, ordena_r5
	jmp r5, #0
	
;	
;void troca( uint16 a[], uint16 i1, uint16 i2 ){
;	uint16 t = a[i1];
;	a[i1] = a[i2];
;	a[i2] = t;
;}
;

troca:
	st r3, troca_r3
	st r4, troca_r4
	
	ld r3, [r0, r1]	; t = a[i1];
	ld r4, [r0, r2]
	st r4, [r0, r1]	; a[i1] = a[i2];
	st r3, [r0, r2]	; a[i2] = t;
	
	ld r3, troca_r3
	ld r4, troca_r4
	jmp r5, #0

;	
;	uint16 maior_idx( uint16 a[], uint16 n ){
;		uint16 i, res = 0;
;		for( i = 1; i != n; ++i )
;			if( maior_que( a[i], a[res] ) )
;				res = i;	
;		return res;
;	}
;
;	Inicio: r0 = a; r1 = n
;	Ciclo: r2 = a; r3 = n; r4 = i; r0 e r1 = parametros para chamar maior2()
;			variável "res" em memória
	
maior_idx:
	st r5, maior_idx_r5
	
	st r2, maior_idx_r2
	st r3, maior_idx_r3
	st r4, maior_idx_r4
	
	orl r2, r0, r0
	orl r3, r1, r1
	ldi r4, #1
	ldi r0, #0
	st r0, maior_idx_res	; res=0
for:
	sub r6, r4, r3
	jz forend
	ld r0, [r2, r4]		; a[i]
	ld r5, maior_idx_res ; aproveita-se r5 que está temporariamente disponivel; também podia ser r1
	ld r1, [r2, r5]	; a[res]
	jmpl maior_que
	orl r0, r0, r0
	jz	next1
	st r4, maior_idx_res
next1:
	add r4, r4, #1
	jmp for
forend:
	ld r0, maior_idx_res	; retornar o valor em r0
	
	ld r2, maior_idx_r2
	ld r3, maior_idx_r3
	ld r4, maior_idx_r4
	
	ld r5, maior_idx_r5
	jmp r5, #0
	
;
;	uint16 maior_que( uint16 a, uint16 b ){
;		if( a > b )
;			return 1;
;		return 0;
;	}
;
	

maior_que:
	sub r6, r1, r0	; r6 recebe flags; resultado aritmetico é descartado
	jnc next
	ldi r0, #1
	jmp m2end
next:
	ldi r0, #0
m2end:
	jmp r5,#0
	

	
	.data
a1:	.word 10, 15, 20, 12, 30
a2: .word 12, 16, 14, 18

b1: .space 18

	.end
