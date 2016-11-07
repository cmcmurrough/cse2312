/******************************************************************************
* @file link_test.s
* @brief register print example
*
* Simple example of printing register values to terminal for debugging by
* linking to reg_dump.s
*
* compile with gcc -o link_test link_test.s reg_dump.s
*
* @author Christopher D. McMurrough
******************************************************************************/
 
.global main
.func main
   
main:
    MOV R0, #0          @ set a constant value for printing
    MOV R1, #10         @ set a constant value for printing
    MOV R2, #20         @ set a constant value for printing
    MOV R3, #30         @ set a constant value for printing
    MOV R4, #40         @ set a constant value for printing
    MOV R5, #50         @ set a constant value for printing
    MOV R6, #60         @ set a constant value for printing
    MOV R7, #70         @ set a constant value for printing
    MOV R8, #80         @ set a constant value for printing
    MOV R9, #90         @ set a constant value for printing
    MOV R10, #100       @ set a constant value for printing
    MOV R11, #110       @ set a constant value for printing
    MOV R12, #120       @ set a constant value for printing
    BL  _reg_dump       @ print register contents
    B   _exit           @ branch to exit procedure with no return
