; 319001533, 50%
; 207656182, 50%
.ORIG X40C8
Exp:
	ST R0 R0_SAVE_EXP
	ST R1 R1_SAVE_EXP
	ST R7 R7_SAVE_EXP
	LD R6 Mul_PTR          ; R6=Mul address
	AND R2 R2 #0
	AND R5 R5 #0
	
	CHECK_IF_LEGIT:
		ADD R0 R0 #0       ;update the cc
		BRn FAIL           ;R0<0
		ADD R1 R1 #0       ;update the cc
		BRn FAIL           ;R1<0
		BRz ONE_ZERO       ;R1=0
		BR LEGIT

	ONE_ZERO:
		ADD R0 R0 #0
		BRz FAIL           ;if R0=R1=0 then fail
		ADD R2 R2 #1       ;else R1=0 so the result is 1
		BR FINISH
		 
	FAIL:
		ADD R2 R2 #-1
		BR FINISH
	
	LEGIT:
		ADD R5 R1 #-1       ;R5=R1-1
		BRp SWAP
			ADD R2 R0 #0    ;if R5 is 0 then R1=1 so R2=R0
			BR FINISH
		SWAP:
			ADD R1 R0 #0    ;R1=R0
		LOOP:
			ADD R5 R5 #0    ;update the cc
			BRnz FINISH
			JSRR R6			; R2 = Mul(R0, R1)
			ADD R0 R2 #0    ; R0=R2
			ADD R5 R5 #-1   ; R5=R5-1
			BR LOOP

	FINISH:
	LD R0 R0_SAVE_EXP
	LD R1 R1_SAVE_EXP
	LD R7 R7_SAVE_EXP
RET
	R0_SAVE_EXP .FILL #0
	R1_SAVE_EXP .FILL #0
	R7_SAVE_EXP .FILL #0
	Mul_PTR .FILL x4000
.END