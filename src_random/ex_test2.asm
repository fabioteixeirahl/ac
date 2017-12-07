	.equ time, 0x1210
	.section start
	.org 0
	jmp main
	
	.section directdata
	.org 2
aux: .byte 1

	.text
main:
	;ldih r0,#high(time) ;coloca na parte alta de r0 12
	;ldi r0,#low(time);coloca na parte baixa de r0 10 e esmaga a parte alta com zeros
	
	;ldi r1,#low(time);coloca na parte baixa de r0 10
	;ldih r1,#high(time);coloca na parte alta de r0 12
	
	ldi r1, #0
	ldb r0, aux
	shr r6, r0, #1, 0
	jnc r7, #2	
	;addf r1, r1, #1
	incf r1
	jc r7, #1
	;sub r1, r1, #1
	decf r1
	
	ldi r1, #0
	st r1, aux
	ldb r0, aux
	shr r6, r0, #1, 0
	jnc r7, #2	
	;addf r1, r1, #1
	incf r1
	jc r7, #1
	;sub r1, r1, #1
	decf r1
	jmp $
   	.end
