/******************************************************************************
* @file rand.s
* @brief simple pseudo-random number generation
*
* Simple example of generating a pseudo-random number using libc
*
* @author Christopher D. McMurrough
******************************************************************************/
 
.global main
.func main
   
main:
    BL _seedrand            @ seed the random number generator with the current time
    BL _getrand             @ get the random number
    MOV R1, R0              @ move the result into R1 for printf
    BL _printf              @ print the random number
    BL _getrand             @ get the random number
    MOV R1, R0              @ move the result into R1 for printf
    BL _printf              @ print the random number
    BL _getrand             @ get the random number
    MOV R1, R0              @ move the result into R1 for printf
    BL _printf              @ print the random number
    B _exit                 @ exit if done

_seedrand:
    PUSH {LR}               @ backup return address
    MOV R0, #0              @ pass 0 as argument to time call
    BL time                 @ get system time
    MOV R1, R0              @ pass sytem time as argument to srand
    BL srand                @ seed the random number generator
    POP {PC}                @ return 
    
_getrand:
    PUSH {LR}               @ backup return address
    BL rand                 @ get a random number
    POP {PC}                @ return 
    
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
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
   
.data
printf_str:     .asciz      "A random number: %d\n"
exit_str:       .ascii      "Terminating program.\n"
