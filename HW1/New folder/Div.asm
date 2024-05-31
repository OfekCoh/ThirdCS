; 319001533, 50%
; 207656182, 50%
.ORIG X4064
Div:
	ST R0 R0_SAVE_DIV  ; save the register  		
	ST R1 R1_SAVE_DIV  ; save the register
	ST R6 R6_SAVE_DIV  ; save the register
	ST R7 R7_SAVE_DIV  ; save the register -- the return address			
	AND R2 R2 #0			  
	AND R3 R3 #0			  
	AND R5 R5 #0
	AND R6 R6 #0
	
	ADD R1 R1 #0         ; update the cc
	BRnp LEGIT           ; if R1=0 then illegal and R2=R3=-1
		ADD R2 R2 #-1
		ADD R3 R3 #-1
		BR FINISH 

	LEGIT:               ; we want to check if the end result is (+) or (-) and save that sign in R6  --> R6=1/-1 (p/n)
		ADD R0 R0 #0     ; update the cc
		STEP_ONE:        ;check if R0<0
			BRzp STEP_TWO  
				ADD R6 R6 #-1          ;R6=-1
				NOT R0 R0
				ADD R0 R0 #1           ;R0=-R0 (make it positive)
		STEP_TWO:  ;check if R1<0
			ADD R1 R1 #0               ;update the cc
			BRzp CODE
				NOT R1 R1
				ADD R1 R1 #1          ;R1=-R1 (make it positive)
				ADD R6 R6 #0          ;update the cc
				BRzp STEP_THREE		
					ADD R6 R5 #1      ;R6=1
					BR CODE
		STEP_THREE:
			ADD R6 R5 #-1            ;R6=-1
		
		CODE:
			NOT R1 R1
			ADD R1 R1 #1             ;R1=-R1
			ADD R3 R0 #0             ;R3=R0
			LOOP:
				ADD R0 R0 R1         ;R0=R0-R1
				BRn END_LOOP
				ADD R2 R2 #1         ;R2=R2+1
				ADD R3 R0 #0         ;R3=R0
				BR LOOP   
			END_LOOP:
			ADD R6 R6 #0            ;update the cc
			BRzp FINISH:
				NOT R2 R2
				ADD R2 R2 #1        ;R2=-R2 (change it according to the sign in R6)
		FINISH:

	LD R0 R0_SAVE_DIV  ; load the register
	LD R1 R1_SAVE_DIV  ; load the register
	LD R6 R6_SAVE_DIV  ; load the register
	LD R7 R7_SAVE_DIV  ; load the register
RET	
	R0_SAVE_DIV .FILL #0
	R1_SAVE_DIV .FILL #0
	R6_SAVE_DIV .FILL #0
	R7_SAVE_DIV .FILL #0
.END