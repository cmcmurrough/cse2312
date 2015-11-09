/******************************************************************************
* @FILE printf.s
* @BRIEF simple printf example
*
* Simple example of invoking printf to print a formatted string
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
    .global main
    .func main
   
main:
    BL  _print          @ branch to print procedure with return
    B   _exit           @ branch to exit procedure with no return
   
_exit:  
    MOV R7, #4          @ write syscall, 4
    MOV R0, #1          @ output stream to monitor, 1
    MOV R2, #21         @ print string length
    LDR R1,=exit_str    @ string at label exit_str:
    SWI 0               @ execute syscall
    MOV R7, #1          @ terminate syscall, 1
    SWI 0               @ execute syscall
       
_print:
    MOV R4, LR          @ store LR since printf call overwrites
    LDR R0,=print_str   @ R0 contains formatted string address
    MOV R1, #100        @ printf argument 1
    MOV R2, #200        @ printf argument 2
    MOV R3, #300        @ printf argument 3
    BL printf           @ call printf
    MOV PC, R4          @ return
 
.data
print_str:
.asciz "Printing 3 numbers: %d %d %d \n"
exit_str:
.ascii "Terminating program.\n"
