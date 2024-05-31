; 319001533, 50%
; 207656182, 50%
.orig x4320
PrintNum:
	ST R0 R0_SAVE_PRINT_NUM
	ST R1 R1_SAVE_PRINT_NUM
	ST R2 R2_SAVE_PRINT_NUM
	ST R3 R3_SAVE_PRINT_NUM
	ST R4 R4_SAVE_PRINT_NUM
	ST R5 R5_SAVE_PRINT_NUM
	ST R6 R6_SAVE_PRINT_NUM
	ST R7 R7_SAVE_PRINT_NUM
	 
	LD R6 Div_PTR                  ;R6=Div address    
	AND R5 R5 #0         
	ST R5 N_FLAG                   ;reset the flag
	AND R1 R1 #0
	AND R7 R7 #0
	ADD R1 R1 #10                  ;R1=10

	ADD R0 R0 #0                   ;cc= R0
	BRzp START_DIV
	ADD R5 R5 #1                   ;raise flag for minus
	ST R1 N_FLAG                   ;N_FLAG=R1

	START_DIV:
		LEA R4 ARR                 ;R4=[0,0,0,0,0]
		ADD R5 R4 #0               ;R5=start of array
	LOOP_2:
		JSRR R6                    ;R2= R0/R1, R3=remainder
		STR R3 R4 #0               ;ARR[R4]=R3
		ADD R4 R4 #1               ;R4++
		ADD R2 R2 #0               ;cc=R2
		BRz END_LOOP_2
		ADD R0 R2 #0               ;R0=R2
		BR LOOP_2

	END_LOOP_2:
		LD R2 N_FLAG               
		BRnz PRINT
		LD R0 ASCII_MINUS_2        ;print (-)
		OUT
		 
	PRINT:                         ;we will loop the array in reverse until r4=r5                
		ADD R4 R4 #-1              ;R4--
		LDR R0 R4 #0               ;R0=ARR[R4]
		LD R1 ASCII_ZERO_2         ;R1=48
		ADD R0 R0 R1               ;turn r0 to ascii
		OUT

		ADD R1 R4 #0               ;R1=R4
		NOT R1 R1
		ADD R1 R1 #1               ;R1=-R4
		ADD R1 R1 R5
		BRzp FINISH_2               ;reached the start of the array so we finish
		BR PRINT


	FINISH_2:
	LD R0 R0_SAVE_PRINT_NUM
	LD R1 R1_SAVE_PRINT_NUM
	LD R2 R2_SAVE_PRINT_NUM
	LD R3 R3_SAVE_PRINT_NUM
	LD R4 R4_SAVE_PRINT_NUM
	LD R5 R5_SAVE_PRINT_NUM
	LD R6 R6_SAVE_PRINT_NUM
	LD R7 R7_SAVE_PRINT_NUM
RET
	R0_SAVE_PRINT_NUM .FILL #0
	R1_SAVE_PRINT_NUM .FILL #0
	R2_SAVE_PRINT_NUM .FILL #0
	R3_SAVE_PRINT_NUM .FILL #0
	R4_SAVE_PRINT_NUM .FILL #0
	R5_SAVE_PRINT_NUM .FILL #0
	R6_SAVE_PRINT_NUM .FILL #0
	R7_SAVE_PRINT_NUM .FILL #0
	Div_PTR .FILL X4064
	N_FLAG .FILL #0   ;is R0 negative flag
	ARR .blkw #5
	ASCII_ZERO_2 .FILL #48
	ASCII_MINUS_2 .FILL #45
.end