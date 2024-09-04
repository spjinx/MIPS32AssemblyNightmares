###############################################################################
# Title: Assign02P3                   Author: Shelby Paige Jenkins
# Class: CS 2318-00?, Fall 2023       Submitted: 11/21/23
###############################################################################
# Program: MIPS tranlation of a given C++ program
###############################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
###############################################################################

.data
    einStr:     .asciiz "Enter integer #"
    moStr:      .asciiz "Max of "
    ieStr:      .asciiz " ints entered..."
    emiStr:     .asciiz "Enter more ints? (n or N = no, others = yes) "
    begA1Str:   .asciiz "beginning a1: "
    nn09A1Str:  .asciiz "a1 (noneg09): "
    procA1Str:  .asciiz "processed a1: "
    procA2Str:  .asciiz "          a2: "
    procA3Str:  .asciiz "          a3: "
    dacStr:     .asciiz "Do another case? (n or N = no, others = yes) "
    dlStr:      .asciiz "================================"
    byeStr:     .asciiz "bye..."

    a1:         .space 48  # Allocating space for 12 integers
    a2:         .space 48  # Allocating space for 12 integers
    a3:         .space 48  # Allocating space for 12 integers

.text
.globl main
main:
    # Initial variable setup
    li $t8, 'y'        # oneChar = 'y'
    li $t1, 0          # used1 = 0
    li $t2, 0          # used2 = 0
    li $t3, 0          # used3 = 0
    li $t0, 0          # target = 0
    li $t8, 0          # oneInt = 0
    li $t9, 0          # count = 0
    li $t8, 0          # iter = 0

    la $t4, a1         # hopPtr1 = &a1
    la $t6, a2         # hopPtrX = &a2 (assuming hopPtrX is used for a2)
    la $t5, a2         # hopPtr2 = &a2
    la $t7, a3         # hopPtr3 = &a3
    la $a1, a1         # endPtr1 = &a1
    la $a2, a2         # endPtr2 = &a2
    la $a3, a3         # endPtr3 = &a3

    # Jump to the first while test
    j WTest1
    
    # while (oneChar != 'n' && oneChar != 'N')
WTest1:
    li $v0, 110 # Load 'n' into $v0
    bne $t8, $v0, begW1 # Branch to begW1 if oneChar is not 'n'
    li $v0, 78  # Load 'N' into $v0
    beq $t8, $v0, xitW1 # If oneChar is 'N', jump to xitW1
    j begW1

begW1:
    li $t1, 0          # used1 = 0
    la $t4, a1         # hopPtr1 = &a1

    # Nested while loop
    j WTest2

WTest2:
    li $v0, 110 # Load 'n' into $v0
    beq $t8, $v0, xitW2 # If oneChar is 'n', jump to xitW2
    li $v0, 78  # Load 'N' into $v0
    bne $t8, $v0, begW2 # If oneChar is not 'N', jump to begW2
    j xitW2

begW2:
    # Printing "Enter integer #"
    li $v0, 4           # syscall for print string
    la $a0, einStr      # Load address of einStr
    syscall

    # Printing used1 + 1
    addi $a0, $t1, 1    # $a0 = used1 + 1
    li $v0, 1           # syscall for print int
    syscall

    # Printing ':' and ' '
    li $v0, 11          # syscall for print character
    li $a0, 58          # ':' ASCII code
    syscall
    
    li $a0, 32          # ' ' ASCII code
    syscall

    # Reading integer into *hopPtr1
    li $v0, 5           # syscall for read int
    syscall
    sw $v0, 0($t4)      # Store read integer at hopPtr1

    # used1++, hopPtr1++
    addi $t1, $t1, 1    # used1 = used1 + 1
    addi $t4, $t4, 4    # hopPtr1 = hopPtr1 + 4 (move to next integer)

    # if (used1 < 12) goto begI1; else goto elseI1
    li $v0, 12
    blt $t1, $v0, begI1
    j elseI1

begI1:
    # Printing "Enter more ints? (n or N = no, others = yes) "
    li $v0, 4           # syscall for print string
    la $a0, emiStr      # Load address of emiStr
    syscall

    # Reading char into oneChar
    li $v0, 12          # syscall for read char
    syscall
    
    move $t8, $v0       # oneChar = read char
    j endI1

elseI1:
    # Printing "Max of 12 ints entered...\n"
    li $v0, 4           # syscall for print string
    la $a0, moStr       # Load address of moStr
    syscall

    li $v0, 4           # syscall for print string
    la $a0, ieStr       # Load address of ieStr
    syscall

    li $t8, 110         # oneChar = 'n'

endI1:
    j endW2

endW2:
    j WTest2

xitW2:
    # Printing a new line
    li $v0, 11          # syscall for print character
    li $a0, 10          # newline ASCII code
    syscall

    # Printing "beginning a1: "
    li $v0, 4           # syscall for print string
    la $a0, begA1Str    # Load address of begA1Str
    syscall

    # if (used1 > 0)
    blez $t1, endI2     # if used1 <= 0, jump to endI2
    j begI2

begI2:
    la $t4, a1          # hopPtr1 = &a1
    sll $v1, $t1, 2     # endPtr1 = used1 * 4 (byte offset)
    add $a1, $a1, $v1   # endPtr1 = a1 + endPtr1

    # do-while loop for printing a1 array
    j begDW1

begDW1:
    lw $a0, 0($t4)      # Load value at hopPtr1
    li $v0, 1           # syscall for print int
    syscall

    # Printing ' '
    li $v0, 11          # syscall for print character
    li $a0, 32          # ' ' ASCII code
    syscall

    addi $t4, $t4, 4    # hopPtr1++

    # do-while test
    blt $t4, $a1, begDW1

endI2:
    # Printing a new line
    li $v0, 11          # syscall for print character
    li $a0, 10          # newline ASCII code
    syscall

    # if (used1 > 0)
    blez $t1, endI3     # if used1 <= 0, jump to endI3
    j begI3

begI3:
    sll $v1, $t1, 2     # endPtr1 = used1 * 4 (byte offset)
    add $a1, $a1, $v1   # endPtr1 = a1 + endPtr1
    la $t4, a1          # hopPtr1 = &a1

    # for-loop for array processing
    j FTest1

FTest1:
    bge $t4, $a1, endF1 # if hopPtr1 >= endPtr1, jump to endF1
    j begF1

begF1:
    lw $t0, 0($t4)      # Load value at hopPtr1 into target

    # if (target < 0 || target > 9)
    bltz $t0, begI4     # if target < 0, jump to begI4
    li $v0, 9
    bgt $t0, $v0, begI4 # if target > 9, jump to begI4
    j endI4

begI4:
    addi $t6, $t4, 4   # hopPtrX = hopPtr1 + 1
    sll $v0, $t1, 2    # Compute endPtr1 as used1 * 4 (byte offset)
    add $a1, $a1, $v0  # endPtr1 = a1 + endPtr1

    # Inner for-loop to shift elements
    j FTest2

FTest2:
    bge $t6, $a1, endF2 # if hopPtrX >= endPtr1, jump to endF2
    j begF2

begF2:
    lw $v0, 0($t6)     # Load value at hopPtrX
    sw $v0, 0($t4)     # Store value at hopPtr1
    addi $t6, $t6, 4   # Increment hopPtrX
    j FTest2

endF2:
    addi $t1, $t1, -1  # used1 = used1 - 1
    addi $a1, $a1, -4  # endPtr1 = endPtr1 - 4
    addi $t4, $t4, -4  # hopPtr1 = hopPtr1 - 4
    j endI4

endI4:
    addi $t4, $t4, 4   # hopPtr1++
    j FTest1

endF1:
    # Printing "a1 (noneg09): "
    li $v0, 4          # syscall for print string
    la $a0, nn09A1Str  # Load address of nn09A1Str
    syscall

    # if (used1 > 0)
    blez $t1, endI5    # if used1 <= 0, jump to endI5
    j begI5

begI5:
    la $t4, a1         # hopPtr1 = &a1
    sll $v1, $t1, 2    # endPtr1 = used1 * 4 (byte offset)
    add $a1, $a1, $v1  # endPtr1 = a1 + endPtr1

    # do-while loop for printing a1 array after processing
    j begDW2

begDW2:
    lw $a0, 0($t4)     # Load value at hopPtr1
    li $v0, 1          # syscall for print int
    syscall

    # Printing ' '
    li $v0, 11         # syscall for print character
    li $a0, 32         # ' ' ASCII code
    syscall

    addi $t4, $t4, 4   # hopPtr1++
    blt $t4, $a1, begDW2

endI5:
    # Printing a new line
    li $v0, 11         # syscall for print character
    li $a0, 10         # newline ASCII code
    syscall

    # Initialization for processing a2 and a3
    li $t2, 0          # used2 = 0
    li $t3, 0          # used3 = 0
    la $t4, a1         # hopPtr1 = &a1
    la $t5, a2         # hopPtr2 = &a2
    la $t7, a3         # hopPtr3 = &a3
    sll $v1, $t1, 2    # endPtr1 = used1 * 4 (byte offset)
    add $a1, $a1, $v1  # endPtr1 = a1 + endPtr1

    # while loop for copying a1 to a2 and a3
    j WTest3

WTest3:
    bge $t4, $a1, endW3  # if hopPtr1 >= endPtr1, jump to endW3
    j begW3

begW3:
    lw $t8, 0($t4)      # Load oneInt from hopPtr1

    sw $t8, 0($t5)      # Store oneInt to hopPtr2 (a2)
    addi $t2, $t2, 1    # Increment used2
    addi $t5, $t5, 4    # Increment hopPtr2

    sw $t8, 0($t7)      # Store oneInt to hopPtr3 (a3)
    addi $t3, $t3, 1    # Increment used3
    addi $t7, $t7, 4    # Increment hopPtr3

    addi $t4, $t4, 4    # Increment hopPtr1
    j WTest3

endW3:
    li $t8, 0           # iter = 0
    # do-while loop for iterative processing
    j DWTest3

begDW3:
    addi $t8, $t8, 1   # iter++

    # Reset count to 0 for each iteration
    li $t9, 0          # count = 0

    # if (iter == 1)
    li $v0, 1
    bne $t8, $v0, elseI6
    j begI6
begI6:
elseI6:
    # if (iter == 2)
    li $v0, 2
    bne $t8, $v0, elseI10
    j begI10
begI10:
elseI10:
    # Processing for iter == 3
    sll $v1, $t3, 2    # endPtr3 = used3 * 4 (byte offset)
    add $a3, $a3, $v1  # endPtr3 = a3 + endPtr3
    la $t7, a3         # hopPtr3 = &a3

    # for-loop for array a3 processing
    j FTest5
endF5:
FTest5:
    bge $t7, $a3, endF5 # if hopPtr3 >= endPtr3, jump to endF5
    j begF5

begF5:

DWTest3:
    li $v0, 3
    blt $t8, $v0, begDW3 # if iter < 3, repeat do-while

    # Final read for do-another-case check
    # Printing "Do another case? (n or N = no, others = yes) "
    li $v0, 4          # syscall for print string
    la $a0, dacStr     # Load address of dacStr
    syscall

    # Reading char into oneChar
    li $v0, 12         # syscall for read char
    syscall
    move $t8, $v0      # oneChar = read char

    # End of main while loop
    j WTest1
    
endI3:

xitW1:
    # Printing endl, goodbye message and endl
    li $v0, 11         # syscall for print character
    li $a0, 10         # newline ASCII code
    syscall

    li $v0, 4          # syscall for print string
    la $a0, dlStr      # Load address of dlStr
    syscall

    li $v0, 4          # syscall for print string
    la $a0, byeStr     # Load address of byeStr
    syscall

    li $v0, 4          # syscall for print string
    la $a0, dlStr      # Load address of dlStr
    syscall

    # Exit program
    li $v0, 10         # syscall for exit
    syscall




