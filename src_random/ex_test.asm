	.section start
	.org 0
	jmp main
	
	.section directdata
	.org 2
	
	.text
main:
	ldi r0,#low(a1)
	ldih r0,#high(a1)
	ldb r1,[r0, #1]				
	jmp $
                
	a1: .byte 2, 3, 4, 5, 6
	.end
