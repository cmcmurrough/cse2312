/******************************************************************************
* @FILE mod.s
* @BRIEF simple mod operations example
*
* Simple example of computing the remainder of integer division
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
    .global main
    .func main
   
main:
    MOV R1, #200        @ set a constant value for mod evaluation
    MOV R2, #75         @ set a constant value for mod evaluation
    PUSH {R1}           @ store value to stack
    PUSH {R2}           @ store value to stack
    BL  _mod_unsigned   @ compute the remainder of R1 / R2
    POP {R2}            @ restore values from stack
    POP {R1}            @ restore values from stack
    MOV R3, R0          @ copy mod result to R3
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
       
_mod_unsigned:
    cmp R2, R1          @ check to see if R1 >= R2
    MOVHS R0, R1        @ swap R1 and R2 if R2 > R1
    MOVHS R1, R2        @ swap R1 and R2 if R2 > R1
    MOVHS R2, R0        @ swap R1 and R2 if R2 > R1
    MOV R0, #0          @ initialize return value
    B _modloopcheck     @ check to see if
    _modloop:
        ADD R0, R0, #1  @ increment R0
        SUB R1, R1, R2  @ subtract R2 from R1
    _modloopcheck:
        CMP R1, R2      @ check for loop termination
        BHS _modloop    @ continue loop if R1 >= R2
    MOV R0, R1          @ move remainder to R0
    MOV PC, LR          @ return
 
_print:
    MOV R4, LR          @ store LR since printf call overwrites
    LDR R0,=print_str   @ R0 contains formatted string address
    BL printf           @ call printf
    MOV PC, R4          @ return
 
.data
print_str:
.asciz "%d mod %d = %d \n"
exit_str:
.ascii "Terminating program.\n"