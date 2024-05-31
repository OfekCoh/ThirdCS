; 319001533, 50%
; 207656182, 50%
.ORIG X4190
TriangleInequality:
	ST R0 R0_SAVE_LAST
	ST R1 R1_SAVE_LAST
	ST R2 R2_SAVE_LAST
	ST R7 R7_SAVE_LAST 
	AND R3 R3 #0         ;R3=0
	AND R4 R4 #0         ;R4=0
	AND R5 R5 #0         ;R5=0
	AND R6 R6 #0         ;R6=0
	
	ADD R0 R0 #0         ;update the cc
	BRn FAIL             ;n is illegal
	ADD R1 R1 #0         ;update the cc
	BRn FAIL             ;n is illegal
	ADD R2 R2 #0         ;update the cc
	BRn FAIL             ;n is illegal
	BR CODE              ;input is legal

	FAIL:
		ADD R3 R3 #-1
		BR FINISH

	CODE:
		ADD R4 R1 R2         ;R4=R1+R2
		ADD R5 R0 R2         ;R5=R0+R2
		ADD R6 R0 R1         ;R6=R0+R1
	
		NOT R4 R4 
		ADD R4 R4 #1         ;R4=-R4
		NOT R5 R5 
		ADD R5 R5 #1         ;R5=-R5
		NOT R6 R6 
		ADD R6 R6 #1         ;R6=-R6

		ADD R0 R0 R4         ;R0=R0+R4
		BRp FINISH           ;R3=0 and thats the result
		ADD R1 R1 R5         ;R1=R1+R5
		BRp FINISH           ;R3=0 and thats the result
		ADD R2 R2 R6         ;R2=R2+R6
		BRp FINISH           ;R3=0 and thats the result
	
	YES_TRI:
		ADD R3 R3 #1         ;R3=1, result is correct

	FINISH:
	LD R0 R0_SAVE_LAST
	LD R1 R1_SAVE_LAST
	LD R2 R2_SAVE_LAST
	LD R7 R7_SAVE_LAST
RET
	R0_SAVE_LAST .FILL #0
	R1_SAVE_LAST .FILL #0
	R2_SAVE_LAST .FILL #0
	R7_SAVE_LAST .FILL #0
.END
