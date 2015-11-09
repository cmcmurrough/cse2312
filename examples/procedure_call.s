/******************************************************************************
* @FILE procedure_call.s
* @BRIEF procedure call and return example
*
* Simple example of executing a procedure call and returning upon completion
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/

	.global  _start
    
_start:
	BL  _hello          @ branch to hello procedure with return
	B   _exit           @ branch to exit procedure with no return
    
_exit:   
	MOV R7, #4          @ write syscall, 4
 	MOV R0, #1          @ output stream to monitor, 1
	MOV R2, #21         @ print string length
	LDR R1,=exit_str    @ string at label exit_str:
	SWI 0               @ execute syscall
	
	MOV R7, #1          @ terminate syscall, 1
	SWI 0               @ execute syscall
	
_hello:
	MOV R7, #4          @ write syscall, 4
 	MOV R0, #1          @ output stream to monitor, 1
	MOV R2, #27         @ print string length
	LDR R1,=hello_str   @ string at label hello_str:
	SWI 0               @ execute syscall
	MOV PC, LR          @ return

.data
hello_str:
.ascii "Hello from procedure call!\n"
exit_str:
.ascii "Terminating program.\n"
