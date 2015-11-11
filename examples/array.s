/******************************************************************************
* @FILE array.s
* @BRIEF simple array declaration and iteration example
*
* Simple example of declaring a fixed-width array and traversing over the
* elements for printing.
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
    .global main
    .func main
   
main:
    MOV R1, #0              @ initialze index variable
loop:
	CMP R1, #100            @ check to see if we are done iterating
	BEQ _exit               @ exit if done
	MOV R2, #0              @ move a[i] to R2 for printing
    BL  _printf             @ branch to print procedure with return
    B   loop                @ branch to next loop iteration
   
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    @MOV R1, R1             @ R1 contains printf argument 1 (redundant line)
    @MOV R2, R2             @ R2 contains printf argument 2 (redundant line)
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   

.data
.balign 4
a:              .skip       400
a_address:      .word       a
number:         .word       0
printf_str:     .asciz      "a[%d] = %d\n"
exit_str:       .ascii      "Terminating program.\n"
