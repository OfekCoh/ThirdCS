; 319001533, 50%
; 207656182, 50%
.ORIG X4000
Mul:
	ST R0 R0_SAVE_MUL  ; save the register  		
	ST R1 R1_SAVE_MUL  ; save the register
	ST R3 R3_SAVE_MUL  ; save the register
	ST R7 R7_SAVE_MUL  ; save the register -- the return address
	AND R2 R2 #0       ; R2=0   R2 will store the result
	ADD R3 R0 #0       ; R3=R0   R3 will be used for the loop 

	BRp LOOP           ;if R3<=0
		NOT R3 R3
		ADD R3 R3 #1   ;R3=-R3
		NOT R1 R1
		ADD R1 R1 #1   ; R1=-R1
		
	LOOP:   ;  while R3>0
		ADD R3 R3 #0
		BRnz END_LOOP   ;check if R3>0
		ADD R2 R2 R1    ;R2=R2+R1
		ADD R3 R3 #-1   ; R3--
		BR LOOP
	END_LOOP:

	LD R0 R0_SAVE_MUL  ; load the register
	LD R1 R1_SAVE_MUL  ; load the register
	LD R3 R3_SAVE_MUL  ; load the register
	LD R7 R7_SAVE_MUL  ; load the register

RET
	R0_SAVE_MUL .FILL #0
	R1_SAVE_MUL .FILL #0
	R3_SAVE_MUL .FILL #0
	R7_SAVE_MUL .FILL #0

.END