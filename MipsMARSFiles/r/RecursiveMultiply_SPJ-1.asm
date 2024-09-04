###################################################################
#		Shelby Jenkins
#		6/26/24
#	! The shovel was a ground breaking invention. 
#
#	! I just ate a frozen apple.
#		! Hardcore...
####################################################################

.data
	p1:		.asciiz "Enter the multiplicand: "
	p2:		.asciiz "Enter the multiplier: "
	res:		.asciiz " * "
	eql:		.asciiz " = "
	newline:	.asciiz "\n"

.text

	main:
		li $v0, 4
		la $a0, p1
		syscall
		li $v0, 5
		syscall
		move $s0, $v0	#store s0

		li $v0, 4
		la $a0, p2
		syscall
		li $v0, 5
		syscall
		move $s1, $v0	#store s1

		move $a0, $s0
		move $a1, $s1

		jal recursive_multiply

		move $s2, $v0

		li $v0, 1
		move $a0, $s0
		syscall
		li $v0, 4
		la $a0, res
		syscall
		li $v0, 1
		move $a0, $s1
		syscall
		li $v0, 4
		la $a0, eql
		syscall
		li $v0, 1
		move $a0, $s2
		syscall
		li $v0, 4
		la $a0, newline
		syscall

		li $v0, 10
		syscall

	recursive_multiply:
		#$ra and $s0 on stack
		addi $sp, $sp, -8
		sw $ra, 4($sp)
		sw $s0, 0($sp)

		# if multiplier == 1, return multiplicand
		li $t0, 1
		beq $a1, $t0, base_case

		# recursive
		# save in $s0
		move $s0, $a0
		addi $a1, $a1, -1
		jal recursive_multiply
		add $v0, $v0, $s0

		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra

	base_case:
		move $v0, $a0

		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra