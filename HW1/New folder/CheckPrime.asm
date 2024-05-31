; 319001533, 50%
; 207656182, 50%
.ORIG X412C
CheckPrime:	
	ST R0 R0_SAVE_CheckPrime
	ST R7 R7_SAVE_CheckPrime
	LD R6 Div_PTR          ; R6=Div address
	AND R1 R1 #0  
	AND R2 R2 #0 
	AND R3 R3 #0 
	AND R4 R4 #0

	ADD R1 R1 #-1       ;R1=-1
	ADD R1 R1 R0        ;R1=R1+R0
	BRnz FINISH         ;if R1<=0 then R0=0/1 so isnt prime
	
	ADD R1 R3 #2        ;R1=2
	ADD R4 R0 #-2       ;R4=R0-2
	BRz SUCCESS         ;2 is prime

	LOOP:
		LD R6 Div_PTR
		JSRR R6			;R2 = Div(R0, R1) , R3=0?
		ADD R3 R3 #0    ;update the cc
		BRz FAIL        ;if R3=0 the number isnt prime
		ADD R1 R1 #1    ;R1=R1+1
		ADD R4 R4 #-1   ;R4=R4-1
		BRz SUCCESS
		BR LOOP         ;if R4>0, then R1<R0 so continue the loop, else R1=R0 so the number is prime.

	FAIL:
		LD R2 Not_Prime
		BR FINISH

	SUCCESS:
		LD R2 Prime     ;R2=1, number is prime
	
	FINISH:
	LD R0 R0_SAVE_CheckPrime
	LD R7 R7_SAVE_CheckPrime
RET
	R0_SAVE_CheckPrime .FILL #0
	R7_SAVE_CheckPrime .FILL #0
	Div_PTR .FILL x4064
	Prime .FILL #1
	Not_Prime .FILL #0
.END



