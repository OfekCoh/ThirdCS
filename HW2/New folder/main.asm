; 319001533, 50%
; 207656182, 50%
.ORIG X3000
main:
	LD R6 GET_NUM_PTR     ;r6 is get num func address
	JSRR R6               ;get first num
	ADD R0 R2 #0          ;r0=first num
	JSRR R6               ;get second num
	ADD R1 R2 #0          ;r1=second num
	
	LD R6 CALC_PTR        ;r6 is calc func address
	JSRR R6               ;call it

HALT
	CALC_PTR .FILL X4384
	GET_NUM_PTR .FILL X41F4
.END
