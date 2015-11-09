/******************************************************************************
* @FILE factorial.s
* @BRIEF simple recursion example
*
* Simple example of recursion and stack management
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
    .global main
    .func main
   
main:
    BL  _prompt             @ branch to prompt procedure with return
    BL  _scanf              @ branch to scan procedure with return
    MOV R4, R0              @ store n in R4
    MOV R1, R0              @ pass n to factorial procedure
    BL  _fact               @ branch to factorial procedure with return
    MOV R1, R4              @ pass n to printf procedure
    MOV R2, R0              @ pass result to printf procedure
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
    PUSH {R1}               @ backup register value
    PUSH {R2}               @ backup register value
    PUSH {R7}               @ backup register value
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #26             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    POP {R7}                @ restore register value
    POP {R2}                @ restore register value
    POP {R1}                @ restore register value
    MOV PC, LR              @ return
       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    @MOV R1, R1              @ R1 contains printf argument 1 (redundant line)
    @MOV R2, R2              @ R2 contains printf argument 2 (redundant line)
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   
_scanf:
    PUSH {LR}               @ store the return address
    PUSH {R1}               @ backup regsiter value
    LDR R0, =format_str     @ R0 contains address of format string
    SUB SP, SP, #4          @ make room on stack
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ remove value from stack
    POP {R1}                @ restore register value
    POP {PC}                @ restore the stack pointer and return
 
_fact:
    PUSH {LR}               @ store the return address
    CMP R1, #1              @ compare the input argument to 1
    MOVEQ R0, #1            @ set return value to 1 if equal
    POPEQ {PC}              @ restore stack pointer and return if equal
   
    PUSH {R1}               @ backup input argument value  
    SUB R1, R1, #1          @ decrement the input argument
    BL _fact                @ compute fact(n-1)
    POP {R1}                @ restore input argument
    MUL R0, R0, R1          @ compute fact(n-1)*n
    POP  {PC}               @ restore the stack pointer and return
 
.data
number:         .word       0
format_str:     .asciz      "%d"
prompt_str:     .asciz      "Enter a positive number: "
printf_str:     .asciz      "%d! = %d\n"
exit_str:       .ascii      "Terminating program.\n"