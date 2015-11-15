/******************************************************************************
* @FILE array.s
* @BRIEF simple array declaration and iteration example
*
* Simple example of declaring a fixed-width array and traversing over the
* elements for printing.
*
* @AUTHOR Christopher D. McMurrough
******************************************************************************/
 
.global main
.func main
   
main:
    MOV R0, #0              @ initialze index variable
writeloop:
    CMP R0, #100            @ check to see if we are done iterating
    BEQ writedone           @ exit loop if done
    LDR R1, =a              @ get address of a
    LSL R1, R1, #2          @ multiply index*4 to get array offset
    ADD R0, R0, R1          @ R0 now has the element address
    STR R1, [R0]            @ store the element offset (i*4) to a[i]
    BL  _printf             @ branch to print procedure with return
    ADD R1, R1, #1          @ increment index
    B   writeloop           @ branch to next loop iteration
writedone:
    B _exit                 @ exit if done

    MOV R0, #0              @ initialze index variable
readloop:
    CMP R0, #100            @ check to see if we are done iterating
    BEQ readdone            @ exit loop if done
    LDR R1, =a              @ get address of a
    @LDR R0, [R0]           @ load base address of a to R0
    LSL R1, R1, #2          @ multiply index*4 to get array offset
    ADD R0, R0, R1          @ R0 now has the element address
    LDR R2, [R0]            @ access the array storing value in R2
    BL  _printf             @ branch to print procedure with return
    ADD R1, R1, #1          @ increment index
    B   readloop            @ branch to next loop iteration
readdone:
    B _exit                 @ exit if done
    
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

.balign 4
a:              .skip       400
a_address:      .word       a
number:         .word       0
printf_str:     .asciz      "a[%d] = %d\n"
exit_str:       .ascii      "Terminating program.\n"
