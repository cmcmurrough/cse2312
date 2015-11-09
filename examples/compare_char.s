/******************************************************************************
* @FILE compare_char.s
* @BRIEF simple get keyboard character and compare
*
* Simple example of invoking syscall to retrieve a char from keyboard input,
* and testing to see if it is equal to a given value
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
    .global main
    .func main
   
main:
    BL  _prompt             @ branch to printf procedure with return
    BL  _getchar            @ branch to scanf procedure with return
    MOV R1, R0              @ move return value R0 to argument register R1
    BL  _compare            @ check the scanf input
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
    MOV R2, #23             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
   
_getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_char      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return
 
_compare:
    CMP R1, #'@'            @ compare against the constant char '@'
    BEQ _correct            @ branch to equal handler
    BNE _incorrect          @ branch to not equal handler
    MOV PC, R4
 
_correct:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =equal_str      @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return
 
_incorrect:
    MOV R5, LR              @ store LR since printf call overwrites
    LDR R0, =nequal_str     @ R0 contains formatted string address
    BL printf               @ call printf
    MOV PC, R5              @ return
 
.data
read_char:      .ascii      " "
prompt_str:     .ascii      "Enter the @ character: "
equal_str:      .asciz      "CORRECT \n"
nequal_str:     .asciz      "INCORRECT: %c \n"
exit_str:       .ascii      "Terminating program.\n"
