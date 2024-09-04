			# Program01
			# Shelby Jenkins, CS2318-002, Assignment 2 Part 1 Program A

			.data
			### P1
			# Declare prompt & label, reserve space, store string input
			prompt1: .asciiz "Section ID (2 or 3): "
			label1a: .asciiz "Hey you of CS2318.00"
			.align 2
			userInt: .space 4

			### P2
			# Declare prompt & label, reserve space, store string input
			prompt2: .asciiz "Halloween costume (up to 25 char): "
			label2:  .asciiz "LOL! "
			userStr: .space 25

			### P3
			# Declare prompt & label, reserve space, store string input
			prompt3: .asciiz "One-character nickname: "
			label3:  .asciiz "Yippee! "
			userChar: .space 1

			### P4
			# Formatting
			newline: .asciiz "\n"

			.text
			main:

			# Prompt and read for Section ID
			# Display Prompt
			li $v0, 4
			la $a0, prompt1
			syscall

			# Read integer
			li $v0, 5
			syscall

			# Store Int
			la $t0, userInt
			sw $v0, 0($t0)

			# Display Label SectionID
			li $v0, 4
			la $a0, label1a
			syscall

			# Display SectionID
			la $t0, userInt
			lw $a0, 0($t0)
			li $v0, 1
			syscall

			# Formatting
			li $v0, 4
			la $a0, newline
			syscall

			# Prompt and read for Halloween costume
			# Prompt
			li $v0, 4
			la $a0, prompt2
			syscall

			# Read string input
			li $v0, 8
			la $a0, userStr
			li $a1, 25
			syscall

			# Display
			li $v0, 4
			la $a0, label2
			syscall

			# Display costume
			li $v0, 4
			la $a0, userStr
			syscall

			# Prompt and read for one-character nickname
			# Prompt
			li $v0, 4
			la $a0, prompt3
			syscall

			# Read char
			li $v0, 12
			syscall

			# Store char
			la $t0, userChar
			sb $v0, 0($t0)

			# Newline
			li $v0, 4
			la $a0, newline
			syscall

			# Display label for 1-char
			li $v0, 4
			la $a0, label3
			syscall

			# Display userint 1-char
			la $t0, userChar
			lb $a0, 0($t0)
			li $v0, 11
			syscall

			# Format
			li $v0, 4
			la $a0, newline
			syscall

			# End of program / Terminate
			li $v0, 10
			syscall
