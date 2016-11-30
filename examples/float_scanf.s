/******************************************************************************
* @file float_scanf.s
* @brief example of obtaining a floating point value using scanf
*
* Obtains a floating point value using scanf. The single precision number is
* stored in memory by scanf and then returned in R0. R0 is then moved to S0,
* where it is converted to double precision in D1. D1 is then split into R1 and
* R2 for compatability with printf.
*
* @author Christopher D. McMurrough
******************************************************************************/
 
.global main
.func main
   
main:
    BL  _prompt             @ branch to prompt procedure with return
    BL  _scanf              @ branch to scanf procedure with return
    VMOV S0, R0             @ move return value R0 to FPU register S0
    VCVT.F64.F32 D1, S0     @ covert the result to double precision for printing
    VMOV R1, R2, D1         @ split the double VFP register into two ARM registers
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
    MOV R2, #31             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_printf:
    PUSH {LR}               @ push LR to stack
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ pop LR from stack and return
    
_scanf:
    PUSH {LR}               @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ return

.data
format_str:     .asciz      "%f"
prompt_str:     .asciz      "Type a number and press enter: "
printf_str:     .asciz      "The number entered was: %f\n"
exit_str:       .ascii      "Terminating program.\n"
