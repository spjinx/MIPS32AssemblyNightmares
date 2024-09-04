##################################################
#	Shelby Jenkins
#	6/12/24
#	Reverse input of two-word name
#    ! Did you know?
#	   !  Another name for the hashtag is an "octothorp"
##################################################

.data
	prompt: .asciiz "Enter your name (FIRST LAST): "
	result: .asciiz " reversed is "
	com_spc: .asciiz ", "
	name: .space 64
.text
	main:
		li $v0, 4
		la $a0, prompt
		syscall

		li $v0, 8
		la $a0, name
		li $a1, 64
		syscall

		la $t0, name
		li $t1, '\n'
		move $t2, $t0				# newline ptr

	newline:
		lb $t3, ($t2)				# lb to ptr
		beqz $t3, output
		bne $t3, $t1, incr			# != newline
		sb $zero, ($t2)				# rpl w/ nullterm
		j output

	incr:
		addi $t2, $t2, 1
		j newline

	output:
		li $v0, 4
		la $a0, name				# ptr to input
		syscall

		li $v0, 4
		la $a0, result
		syscall

		move $t2, $t0               		# ptr reset
		
	spacesearch:
		lb $t3, ($t2)
		beqz $t3, endspacesearch
		bne $t3, ' ', incrsp			# !=" "
		sb $zero, ($t2)				# space to nullterm
		j endspacesearch

	incrsp:
		addi $t2, $t2, 1
		j spacesearch

	endspacesearch:
		li $v0, 4
		addi $a0, $t2, 1			# ptr lastname
		syscall

		li $v0, 4
		la $a0, com_spc
		syscall

		li $v0, 4
		la $a0, name				# ptr to firstname
		syscall

		li $v0, 10				#bye
		syscall