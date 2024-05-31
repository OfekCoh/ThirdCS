; 319001533, 50%
; 207656182, 50%
.orig x41F4
GetNum:
	ST R0 R0_SAVE_GET_NUM
	ST R1 R1_SAVE_GET_NUM
	ST R3 R3_SAVE_GET_NUM
	ST R4 R4_SAVE_GET_NUM
	ST R5 R5_SAVE_GET_NUM
	ST R6 R6_SAVE_GET_NUM
	ST R7 R7_SAVE_GET_NUM
	
	;r4 will be flag for overflow
	;r5 will be flag for minus 
	;r6 will be flag for invalid char input 

	LEA R0 BEGIN_STR                      ;print "enter an integer number:" 
	PUTS                                 

	FIRST_CHAR:                           ;getting first input
		AND R2 R2 #0                      ;R2=0
		AND R5 R5 #0                      ;R5=0 
		AND R6 R6 #0                      ;R6=0
		AND R4 R4 #0                      ;R4=0
		GETC
		OUT

		CHECK_IF_MINUS:
			LD R1 ASCII_MINUS             ;R1=-45
			ADD R1 R1 R0                  ;R1=R0-45
			BRnp CHECK_IF_SMALL           ;if its not a minus jump to
			ADD R5 R5 #1                  ;R5=1   if R1=0 then first char is minus so we raise the flag
			BR LOOP

		CHECK_IF_SMALL:
			LD R1 ASCII_ZERO              ;R1=-48
			ADD R1 R1 R0                  ;R1=R0-48
			BRzp CHECK_IF_BIG
			ADD R6 R6 #1                  ;R6=1  input is not a digit 
			BR LOOP

		CHECK_IF_BIG:
			LD R1 ASCII_NINE              ;R1=-57
			ADD R1 R1 R0                  ;R1=R0-57
			BRnz LEGAL_INPUT
			ADD R6 R6 #1                  ;R6=1  input is not a digit 
			BR LOOP

		LEGAL_INPUT:
			LD R1 ASCII_ZERO              ;R1=-48
			ADD R0 R0 R1                  ;R0=R0-48  to make it the right digit value
			ADD R5 R5 #0                  ;update cc 
			BRnz SUM                      ;check if we should sum it with + or - 
			NOT R0 R0 
			ADD R0 R0 #1                  ;R0=-R0
		SUM:
			ADD R3 R2 #0                  ;R3=R2
			LD R1 MUL_BY_TEN              ;R1=10
			MUL_BY_TEN_LOOP:
				ADD R2 R2 R3              ;R2=R2+R3
				ADD R1 R1 #-1             ;R1--
				BRp MUL_BY_TEN_LOOP
			ADD R2 R2 R0                  ;R2=R2+R0
			
		CHECK_SIGN_CHANGE:
			ADD R2 R2 #0                  ;update cc
			BRz LOOP                      ;if its 0 there is no overlow 
			BRn RES_NEG
			ADD R5 R5 #0                  ;update cc   (R2>0 so if theres a minus its overflow)
			BRp RAISE_OVERFLOW_FLAG
			BR LOOP

			RES_NEG:                      ; (R2<0 so if there isnt a minus its overflow)
			ADD R5 R5 #0                  ;update cc
			BRnz RAISE_OVERFLOW_FLAG
			BR LOOP

		RAISE_OVERFLOW_FLAG:
			ADD R4 R4 #1                  ;R4=1  input is overflow
			BR LOOP

	LOOP:                                 ;loop to get rest of the input
		GETC
		OUT
		LD R1 CHECK_ENTER                 ;R1=-10
		ADD R1 R1 R0                      ;R1=R0-10
		BRz ENDLOOP                       ;if R1=0 then we got the input enter so we stop
		BR CHECK_IF_SMALL                 ;we didnt get enter, check the input

	ENDLOOP:
		ADD R6 R6 #0                      ;update cc
		BRnz CHECK_RANGE                  ;INPUT CHECK (R6 is the flag fot invalid char)
		LEA R0 NOT_NUM
		PUTS                              ;print error
		BR FIRST_CHAR                     ;start over

	CHECK_RANGE:
		ADD R4 R4 #0                      ;update cc
		BRnz FINISH                       ;INPUT CHECK (R4 is the flag fot overflow)
		LEA R0 OVERFLOW
		PUTS                              ;print error
		BR FIRST_CHAR                     ;start over


	FINISH:

	LD R0 R0_SAVE_GET_NUM
	LD R1 R1_SAVE_GET_NUM
	LD R3 R3_SAVE_GET_NUM
	LD R4 R4_SAVE_GET_NUM
	LD R5 R5_SAVE_GET_NUM
	LD R6 R6_SAVE_GET_NUM
	LD R7 R7_SAVE_GET_NUM
RET
	R0_SAVE_GET_NUM .FILL #0
	R1_SAVE_GET_NUM .FILL #0
	R3_SAVE_GET_NUM .FILL #0
	R4_SAVE_GET_NUM .FILL #0
	R5_SAVE_GET_NUM .FILL #0
	R6_SAVE_GET_NUM .FILL #0
	R7_SAVE_GET_NUM .FILL #0
	BEGIN_STR .stringz "Enter an integer number: "
	NOT_NUM .stringz "Error! You did not enter a number. Please enter again: "
	OVERFLOW .stringz "Error! Number overflowed! Please enter again: "
	MUL_BY_TEN .FILL #9
	CHECK_ENTER .FILL #-10
	ASCII_ZERO .FILL #-48
	ASCII_NINE .FILL #-57
	ASCII_MINUS .FILL #-45
.end