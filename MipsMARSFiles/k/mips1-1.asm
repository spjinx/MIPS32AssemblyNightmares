# Shelby Jenkins, CS 2318-002, Assignment 2 Part 1 Program D
############################################################
# MIPS32 assembly program: calculate weighted avg score
#
# 1. Prompt the user to enter the int scores for Exam 1, 
#	Exam 2, and Final Exam.
# 2. Read scores, compute weighted avg score using form:
# avgScore = 
# 	(128/642)e1Score + (154/512)e2Score + (finScore/2)
# 3. Displays a label out about weighted avg score.
#
# Constraints and requirements:
# - Perform ALL adds, muls, and divs as shown in the formula.
#    Do NOT simplify form.
# - Use bit-shifting for muls & divs involving powers of 2.
#    (Note: 2, 128, and 512 are powers of 2. 
#    However, 154 and 642 are not.)
# - DO NOT replace 154 and 642 with their 
#    "sum-of-powers-of-2" equivalents.
# - Discard the fractional portion when evaluating 
#   Exam 1 and Exam 2 contributions.
#   Perform the divs AFTER the muls to avoid accuracy loss.
# - For muls and divs that cannot be done with 
#    one-time bit-shifting,
#   use a "true" instruction (NOT a pseudoinstruction).
#   (Note: mulo, mulou, div, and divu 
#    are pseudoinstructions and should not be used.)
#
# CAUTION: Label your outputs. Many past students 
#  regretted losing points for not labeling.
############################################################
.data

	prompt1: .asciiz "Enter the score for Exam 1: "
	prompt2: .asciiz "Enter the score for Exam 2: "
	prompt3: .asciiz "Enter the score for Exam 3: "
	result:  .asciiz "The weighted average score is: "


.text
main:
	# Prompt Ex1 score
	li $v0, 4
	la $a0, prompt1
	syscall

	# Read Ex1 score
	li $v0, 5
	syscall
	move $t0, $v0  # Store Ex1 score in $t0

	# Prompt Ex2 score
	li $v0, 4
	la $a0, prompt2
	syscall

	# Read Ex2 score
	li $v0, 5
	syscall
	move $t1, $v0  # Store E2 score in $t1

	# Prompt FEx score
	li $v0, 4
	la $a0, prompt3
	syscall

	# Read FEx score
	li $v0, 5
	syscall
	move $t2, $v0  # Store FEx score in $t2

	# Compute weighted average
	# avgScore = (128/642)e1Score + 
	# (154/512)e2Score + (finScore/2)

	# e1Score : (128/642)e1Score
	li $t3, 128
	mul $t4, $t0, $t3
	li $t5, 642
	div $t4, $t5
	mflo $t4  # Store result of (128/642)e1Score 
		  # in $t4

	# e2Score : (154/512)e2Score
	li $t6, 154
	mul $t7, $t1, $t6
	srl $t7, $t7, 9  # division by 512 using bit-shift
	move $t8, $t7  # Store result of 
		       #   (154/512)e2Score in $t8

	# FEx : (finScore/2)
	srl $t9, $t2, 1  # division by 2 using bit-shift

	# Sum 
	add $t7, $t4, $t8
	add $t7, $t7, $t9

	# Display
	li $v0, 4
	la $a0, result
	syscall

	move $a0, $t7
	li $v0, 1
	syscall

	# Exit
	li $v0, 10
	syscall