# Shelby Jenkins, CS 2318-002, Assignment 2 Part 1 Program C


############################################################
# Allocate a global array (i.e., space in the data segment)
# enough for storing 5 integers and initialize the array 
# (from 1st to 5th element) 
# with 808, 707, 303, 909 and 404 at the same time 
# 	(i.e., DON'T first allocate uninitialized space 
#	for array and later write code to put the values 
#	into array). 
############################################################
.data
			array:  .word 808, 707, 303, 909, 404 
				# 5 integers
			initial_label: .asciiz "Initial array: "
			final_label: .asciiz "Final array: "
			newline: .asciiz "\n"
			comma: .asciiz ", "
			and: .asciiz "and "

.text
main:

############################################################
# Display a labeled output about the array's initial 
# contents (in the order from 1st to 5th element). 
#	IMPORTANT:
# 	You are to load the values of the array elements 
#	from memory and use those values to generate the 
#	labeled output.
# 	(You are not to simply display a hard-coded 
#	string(s) and values showing what the contents 
#	of the array should look like.) 
# Personal Notes: This requires a loop to travcerse an 
#	array, but we need to load and print each s
#	tatement instead.
############################################################

			# Display label for initial array 
			# contents
			la $a0, initial_label
			li $v0, 4
			syscall           # print string

			# Load and print each element of 
			# the initial array
			la $t0, array     # $t0 is the 
					  # base address 
					  # of the array

			lw $a0, 0($t0)    # Load 1st element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			lw $a0, 4($t0)    # Load 2nd element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			lw $a0, 8($t0)    # Load 3rd element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			lw $a0, 12($t0)   # Load 4th element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			la $a0, and
			li $v0, 4
			syscall           # print "and"

			lw $a0, 16($t0)   # Load 5th element
			li $v0, 1
			syscall           # print integer

			li $v0, 4
			la $a0, newline
			syscall
			
############################################################
# Re-order the values in the array so that the contents of 
#	the array in memory (from 1st to 5th element) 
#	eventually becomes 
# 909, 404, 303, 808 and 707, using the following 
#	operations in the order listed 
# 	(to not defeat the goals of this exercise, 
#	you must NOT change the specified 
# 	operations and order, even if  doing so will 
#	accomplish the same 
# 	effect more efficiently):
############################################################

############################################################
# Swap the contents in memory of the 1st and 4th elements 
#	of the initial array. 
# 	NOTE: Contents of the array in memory 
#	(from 1st to 5th element) after 
# 	this first swapping operation should be 
# 	909, 707, 303, 808 and 404.
############################################################

			# Swap 1st and 4th elements
			lw $t1, 0($t0)     # Load 1st element 
					   #  	into $t1
			lw $t2, 12($t0)    # Load 4th element 
					   #	into $t2
			sw $t1, 12($t0)    # Store 1st element 
					   # into 4th position
			sw $t2, 0($t0)     # Store 4th element 
					   # into 1st position

############################################################
# Swap the contents in memory of the 2nd and 5th elements 
# of the array that results after the preceding first swap. 
# 	NOTE: Contents of the array in memory 
#	(from 1st to 5th element) 
#	after this second swapping operation should now 
#	and finally be -->
#	909, 404, 303, 808 and 707.
############################################################

			# Swap 2nd and 5th elements
			lw $t1, 4($t0)     # Load 2nd element 
					   # 	into $t1
			lw $t2, 16($t0)    # Load 5th element 
					   # 	into $t2
			sw $t1, 16($t0)    # Store 2nd element 
					   # into 5th position
			sw $t2, 4($t0)     # Store 5th element 
					   # into 2nd position

############################################################
# IMPORTANT: 
#	When performing each of the three swap operations 
#	above, you can re-use 
# (where expedient) the array's base address in register 
# (loaded when performing the display of the array's initial 
#	contents) 
# but you MUST re-load the values of the associated array 
#elements fresh from memory 
# (i.e., assuming no knowledge that certain values might 
# have already existed in some registers due to prior 
# operations). 
############################################################

			# Display label for final 
			# array contents
			la $a0, final_label
			li $v0, 4
			syscall           # print string

############################################################
# Display a labeled output about the array's contents 
# (in the order from 5th to 1st element) after the 2 
# swapping operations above. 
#	NOTE: The contents of the array's elements are to 
#	appear (when displayed) in the order from 
#	5th to 1st element and not from 1st to 5th element. 
#	(IN CASE YOU WONDER: Order in which the eventual 
#	contents of the array should appear in this 
# output -->	707, 808, 303, 404 and 909.
############################################################

############################################################
# IMPORTANT (for the purpose of this exercise)
#	When displaying the after-swap labeled output, 
# you can re-use the 
# array's base address in register (loaded when performing 
# prior operations) 
# but you MUST re-load the values of the array elements 
# fresh from memory 
# (i.e., assuming no knowledge that certain values might 
# have already existed in some registers due to prior 
# operations). 
############################################################

			# Load and print each element of 
			# the array in reverse order
			lw $a0, 16($t0)   # Load 5th element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			lw $a0, 12($t0)   # Load 4th element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			lw $a0, 8($t0)    # Load 3rd element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			lw $a0, 4($t0)    # Load 2nd element
			li $v0, 1
			syscall           # print integer

			la $a0, comma
			li $v0, 4
			syscall           # print comma

			la $a0, and
			li $v0, 4
			syscall           # print "and"

			lw $a0, 0($t0)    # Load 1st element
			li $v0, 1
			syscall           # print integer

			# End the program
			li $v0, 10
			syscall





