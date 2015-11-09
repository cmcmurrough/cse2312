/******************************************************************************
* @FILE procedure_call_parameters.s
* @BRIEF procedure call and return example with passed parameters
*
* Simple example of executing a procedure call and returning upon completion.
* The procedure call expects 3 input parameters, and returns a value.
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
        .global main
        .func main
   
main:
        MOV R1, #100        @ define function argument 1
        MOV R2, #20         @ define function argument 1
        MOV R3, #3          @ define function argument 1
        BL  _add            @ branch to hello procedure with return
        MOV R1, R0          @ copy return value to R1
        BL  _print_val      @ print value stored in R1
        B   _exit           @ branch to exit procedure with no return
   
_exit:  
        MOV R7, #4          @ write syscall, 4
        MOV R0, #1          @ output stream to monitor, 1
        MOV R2, #21         @ print string length
        LDR R1,=exit_str    @ string at label exit_str:
        SWI 0               @ execute syscall
 
        MOV R7, #1          @ terminate syscall, 1
        SWI 0               @ execute syscall
       
_add:
        MOV R0, R1          @ copy input register R1 to return register R0
        ADD R0, R2          @ add input register R2 to return register R0
        ADD R0, R3          @ add input register R3 to return register R0
        MOV PC, LR          @ return
   
_print_val:
        MOV R4, LR          @ store LR since printf call overwrites
        LDR R0,=result_str  @ string at label hello_str:
        BL printf           @ call printf, where R1 is the print argument
        MOV LR, R4          @ restore LR from R4
        MOV PC, LR          @ return
   
.data
add_str:
.ascii "Adding numbers...\n"
result_str:
.asciz "Sum = %d\n"
exit_str:
.ascii "Terminating program.\n"
