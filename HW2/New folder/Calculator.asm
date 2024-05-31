; 319001533, 50%
; 207656182, 50%
.ORIG x4384
Calculator:     
	ST R0 R0_SAVE_CALC
	ST R1 R1_SAVE_CALC
	ST R2 R2_SAVE_CALC
	ST R3 R3_SAVE_CALC
	ST R4 R4_SAVE_CALC
	ST R5 R5_SAVE_CALC
	ST R6 R6_SAVE_CALC
	ST R7 R7_SAVE_CALC
	
	ST R0 A                          ;A=R0
	ST R1 B                          ;B=R1
	LEA R0 ASK_STR                   ;print "enter..." 
	PUTS  
	GETC                             ;R0=input
	OUT
	ST R0 INPUT_SIGN                 ;INPUT_SIGN=R0
	
	CHECK_OP:                        ;now we will load R1 with different op ascii values and check if it equales to R0, then R0=A again
		LD R1 PLUS_SIGN
		ADD R1 R1 R0
		BRz SUM_OP

		LD R1 MINUS_SIGN
		ADD R1 R1 R0
		BRz SUB_OP

		LD R1 MUL_SIGN
		ADD R1 R1 R0
		BRz MUL_OP

		LD R1 DIV_SIGN
		ADD R1 R1 R0
		BRz DIV_OP

		LD R1 EXP_SIGN
		ADD R1 R1 R0
		BRz EXP_OP


	SUM_OP:                  ;A+B
		LD R0 A
		LD R1 B
		ADD R0 R0 R1
		ST R0 RES            ;RES=R0
		BR PRINT_RES

	SUB_OP:                  ;A-B
		LD R0 A
		LD R1 B
		NOT R1 R1 
		ADD R1 R1 #1
		ADD R0 R0 R1 
		ST R0 RES            ;RES=R0
		BR PRINT_RES

	MUL_OP:                  ;A*B
		LD R0 A
		LD R1 B
		LD R6 Mul_PTR
		JSRR R6
		ST R2 RES            ;RES=R2
		BR PRINT_RES

	DIV_OP:                  ;A/B
		LD R0 A
		LD R1 B
		LD R6 Div_PTR
		JSRR R6
		ST R2 RES            ;RES=R2
		BR PRINT_RES

	EXP_OP:                  ;A^B
		LD R0 A
		LD R1 B
		LD R6 Exp_PTR
		JSRR R6
		ST R2 RES            ;RES=R2
		BR PRINT_RES

	PRINT_RES:
		AND R0 R0 #0
		ADD R0 R0 #10          ;print new line
		OUT
		LD R6 PrintNum_PTR     ;R6=print func add
		LD R0 A                
		JSRR R6                ;print a
		LD R0 INPUT_SIGN       ;print op sign
		OUT
		LD R0 B
		JSRR R6                ;print b
		LD R0 EQUAL_SIGN       
		OUT                    ;print =
		LD R0 RES
		JSRR R6                ;print res
		AND R0 R0 #0
		ADD R0 R0 #10          ;print new line
		OUT

	LD R0 R0_SAVE_CALC
	LD R1 R1_SAVE_CALC
	LD R2 R2_SAVE_CALC
	LD R3 R3_SAVE_CALC
	LD R4 R4_SAVE_CALC
	LD R5 R5_SAVE_CALC
	LD R6 R6_SAVE_CALC
	LD R7 R7_SAVE_CALC
RET   
	R0_SAVE_CALC .FILL #0
	R1_SAVE_CALC .FILL #0
	R2_SAVE_CALC .FILL #0
	R3_SAVE_CALC .FILL #0
	R4_SAVE_CALC .FILL #0
	R5_SAVE_CALC .FILL #0
	R6_SAVE_CALC .FILL #0
	R7_SAVE_CALC .FILL #0

	ASK_STR .stringz "Enter an arithmetic operation: "

	PrintNum_PTR .FILL X4320	
	Mul_PTR .FILL X4000	
	Div_PTR .FILL X4064	
	Exp_PTR .FILL X40C8	

	PLUS_SIGN .FILL #-43
	MINUS_SIGN .FILL #-45
	MUL_SIGN .FILL #-42
	DIV_SIGN .FILL #-47
	EXP_SIGN .FILL #-94
	EQUAL_SIGN .FILL #61

	A .FILL #0
	B .FILL #0
	INPUT_SIGN .FILL #0
	RES .FILL #0

.end
