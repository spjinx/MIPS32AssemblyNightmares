###################################################################
#		Shelby Jenkins
#		6/16/24
#	! Did you know? 
#		! Dry air contains ~21% oxygen.
####################################################################
.data
	input:	.asciiz "tacocat"
	is:	.asciiz " is a palindrome.\n"
	isnot:	.asciiz " is NOT a palindrome.\n"	
.text

	main:
		la $a0, input
		li $v0, 4
		syscall
        
		la $a0, input
		jal palin
		beq $v0, $zero, nope
		la $a0, is
		j show
	nope:	la $a0, isnot
	show:	li $v0, 4
		syscall	
        		
		li $v0, 10				# exit
		syscall	
	
	palin:
		addi $sp, $sp, -12			# save
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)

		move $s0, $a0				# $s0 = start pointer
		move $s1, $a0				# $s1 = end pointer
		
	loop1:
		lb $t0, ($s1)				# find end
		beqz $t0, endloop1
		addi $s1, $s1, 1
		j loop1
            
	endloop1:
		addi $s1, $s1, -1
	loop2:
		bge $s0, $s1, ispd		# if ptr = ptr, thn palindrome

		lb $t0, ($s0)
		lb $t1, ($s1)
		
		#case-insensitivity
		ori $t0, $t0, 0x20
		ori $t1, $t1, 0x20

		bne $t0, $t1, npd			# char != char = npd

		addi $s0, $s0, 1			# move ptrs
		addi $s1, $s1, -1
		j loop2

	ispd:
		li $v0, 1				#true
		j end

	npd:
		li $v0, 0				#false

	end:
		lw $ra, 0($sp)				#restore
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		addi $sp, $sp, 12

		jr $ra					#return
