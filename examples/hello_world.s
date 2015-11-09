/******************************************************************************
* @FILE hello_world.s
* @BRIEF Hello world console print example
*
* Simple example of printing text to console using ARM assembly on Raspbian
* Example based on "Raspberry Pi Assembly Language Raspbian" by Bruce Smith
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/

	.global  _start
    
_start:
	MOV R7, #4          @ write syscall, 4
 	MOV R0, #1          @ output stream to monitor, 1
	MOV R2, #13         @ print string length
	LDR R1,=hello_str   @ string at label hello_str:
	SWI 0               @ execute syscall
	B   _exit           @ branch to exit procedure
    
_exit:   
	MOV R7, #1          @ terminate syscall, 1
	SWI 0               @ execute syscall

.data
hello_str:
.ascii "Hello World!\n"

