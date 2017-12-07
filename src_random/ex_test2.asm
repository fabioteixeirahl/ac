	.equ time, 0x1210
	.section start
	.org 0
	jmp main
	
	.section directdata
	.org 2
	
	.text
main:
	ldih r0,#high(time) ;coloca na parte alta de r0 12
	ldi r0,#low(time);coloca na parte baixa de r0 10 e esmaga a parte alta com zeros
	
	ldi r1,#low(time);coloca na parte baixa de r0 10
	ldih r1,#high(time);coloca na parte alta de r0 12
	
	
	
	jmp $
   	.end
