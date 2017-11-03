; Exemplo adaptado do anterior, com complexidade semelhante mas alteração da funcionaidade.
; Agora, em vez de obter o maior valor de um array, pretende-se obter a sua localização.
; A função "maior_idx" identifica o maior valor e devolve o índice onde ele se encontra.
; Utiliza a chamada a uma função "maior_que" para copmparar dois valores e indicar se o
; primeiro é meior que o segundo.
;
	.section start
	.org 0
	jmp main

	.section directdata
	.org 4
; localizações para preservação de registos em memória, e para variáveis locais
; no contexto da função maior_idx

maior_idx_r2: .space 2
maior_idx_r3: .space 2
maior_idx_r4: .space 2
maior_idx_r5: .space 2
maior_idx_res: .space 2

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
	jmpl maior_idx
	st r0, res1

	ldi r0, #low(a2)
	ldih r0, #high(a2)
	ldi r1, #4
	jmpl maior_idx
	st r0, res2
	
	jmp $
	
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
