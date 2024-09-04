###################################################################
#		Shelby Jenkins
#		6/24/24
#	! I walked into a Target the other day 
#		... I missed
####################################################################
.data
	chars:		.ascii "ABCDEFGHIJKLMNOPQRSTUVWXYZ .,!-'"
	msg1:		.word 0x93EA9646, 0xCDE50442, 0x34D29306, 0xD1F33720
			.word 0x56033D01, 0x394D963B, 0xDE7BEFA4  
	msg1end:
	newline:	.asciiz "\n\n"
.text
	main:
		la $t0, msg1
		la $t1, msg1end
		la $t2, chars
		li $t3, 0
		li $t4, 0
	decode:
		# if next >= msg1end goto end_decode
		bge $t0, $t1, end_decode

		# if bits < 5
		bge $t3, 5, ext
		lbu $t5, 0($t0)		# tmp ptr next
		addi $t0, $t0, 1	# next++
		sll $t4, $t4, 8		# 8
		or $t4, $t4, $t5	# tmp
		addi $t3, $t3, 8	# bits += 8
	ext:
		subi $t3, $t3, 5	# bits -= 5
		srlv $t5, $t4, $t3	# buffer >> bits
		andi $t5, $t5, 0x1F	# temp = (buffer >> bits) & 0x1F
		add $t6, $t2, $t5	# chars[temp]
		
		lb $a0, 0($t6)
		li $v0, 11
		syscall
		
		j decode
	end_decode:
		li $v0, 4
		la $a0, newline
		syscall

		li $v0, 10
		syscall