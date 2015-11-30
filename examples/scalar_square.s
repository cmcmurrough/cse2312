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
    @BL  _scanf_float        @ branch to scanf procedure with return

    
    
    @VMOV S2, R0             @ move single precision value in R0 to S2
    @VMOV S3, R0             @ move single precision value in R0 to S3
    
    LDR R0, =double         @ load variable address
    VLDR S0, [R0]           @ load the value into the VFP register
    VMUL.F32 S1, S0, S0     @ compute S1 = S0 * S0
   
    VCVT.F64.F32 D4, S1     @ covert the result to double precision for printing
    VMOV R1, R2, D4         @ split the double VFP register into two ARM registers

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
    PUSH {LR}               @ push LR to stack
    LDR R0, =printf_str     @ R0 contains formatted string address
    MOV R1, R1              @ R1 contains printf argument (redundant line)
    BL printf               @ call printf
    POP {PC}                @ pop LR from stack and return
    
_scanf_float:
    PUSH {LR}               @ push LR to stack
    LDR R0, =format_str     @ R0 contains address of format string
    LDR R1, =double         @ move address of double variable to R1
    BL scanf                @ call scanf
    POP {PC}                @ pop LR from stack and return

.data
format_str:     .asciz      "%f"
prompt_str:     .asciz      "Enter a number to square: "
printf_str:     .asciz      "Result = %f \n"
exit_str:       .ascii      "Terminating program.\n"

double: .float 3.14159
