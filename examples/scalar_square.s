/******************************************************************************
* @FILE scalar_square.s
* @BRIEF simple example of squaring a scalar number with the FPU
*
* Simple example of using the ARM FPU to compute the square of a floating point
* scalar number
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
    .global main
    .func main
   
main:
    BL  _prompt             @ branch to prompt procedure with return
    BL  _scanf              @ branch to scanf procedure with return

    VMOV S2, R0             @ move single precision value in R0 to S2
    VMOV S3, R0             @ move single precision value in R0 to S3
    VMUL.F32 S1, S2, S3     @ compute S1 = S2 * S3
    VMOV R1, S2             @ move single prevision value in S2 to R1
    VMOV R2, S1             @ move single prevision value in S1 to R2
    
    BL  _printf             @ branch to print procedure with return
    B   _exit               @ branch to exit procedure with no return
   
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

_prompt:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #27             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_printf:
    MOV R4, LR              @ store LR since printf call overwrites
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    MOV PC, R4              @ return
    
_scanf:
    MOV R4, LR              @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    MOV PC, R4              @ return

.data
format_str:     .asciz      "%f"
prompt_str:     .asciz      "Enter a number to square: "
printf_str:     .asciz      "%f^2 = %f \n"
exit_str:       .ascii      "Terminating program.\n"
