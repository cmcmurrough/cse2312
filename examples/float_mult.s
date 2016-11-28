/******************************************************************************
* @file float_mult.s
* @brief simple example of scalar multiplication using the FPU
*
* Simple example of using the ARM FPU to compute the multiplication result of
* two float values
*
* @author Christopher D. McMurrough
******************************************************************************/
 
.global main
.func main
   
main:

    LDR R0, =val1           @ load variable address
    VLDR S0, [R0]           @ load the value into the VFP register
    
    LDR R0, =val2           @ load variable address
    VLDR S1, [R0]           @ load the value into the VFP register
    
    VMUL.F32 S2, S0, S1     @ compute S2 = S0 * S1
    
    VCVT.F64.F32 D4, S2     @ covert the result to double precision for printing
    VMOV R1, R2, D4         @ split the double VFP register into two ARM registers
    BL  _printf_result      @ print the result
    
    B   _exit               @ branch to exit procedure with no return
   
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

_printf_result:
    PUSH {LR}               @ push LR to stack
    LDR R0, =result_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ pop LR from stack and return

.data
result_str:     .asciz      "Multiplication result = %f \n"
exit_str:       .ascii      "Terminating program.\n"
val1:           .float      3.14159
val2:           .float      0.100
