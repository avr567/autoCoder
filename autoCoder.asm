.data
#Alexander Ritov avr16@pitt.edu

msg1: .asciiz "Welcome to Auto Coder! \n"
msg2: .asciiz "The opcode (1-9 : 1=add, 2=addi, 3=or, 4=ori, 5=lw, 6=sw, 7=j, 8=beq, 9=bne)\n"
msg3: .asciiz "The machine code is \n"
msg4: .asciiz "The completed code is \n"
input1: .asciiz "please enter the 1st opcode: "
input2: .asciiz "please enter the 2nd opcode: "
input3: .asciiz "please enter the 3rd opcode: "
input4: .asciiz "please enter the 4th opcode: "
input5: .asciiz "please enter the 5th opcode: "

addPrint: .asciiz "add"
addiPrint: .asciiz "addi"
orPrint: .asciiz "or"
oriPrint: .asciiz "ori"
lwPrint: .asciiz "lw"
swPrint: .asciiz "sw"
jPrint: .asciiz "j"
beqPrint: .asciiz "beq"
bnePrint: .asciiz "bne"

t0: .asciiz "$t0"
t1: .asciiz "$t1"
t2: .asciiz "$t2"
t3: .asciiz "$t3"
t4: .asciiz "$t4"
t5: .asciiz "$t5"
t6: .asciiz "$t6"
t7: .asciiz "$t7"
t8: .asciiz "$t8"
t9: .asciiz "$t9"

n1: .asciiz "L100: "
n2: .asciiz "L101: "
n3: .asciiz "L102: "
n4: .asciiz "L103: "
n5: .asciiz "L104: "

newLine: "\n"

register_table: .word t0, t1, t2, t3, t4, t5, t6, t7, t8, t9

label_table: .word 100, 101, 102, 103, 104

register_value_table: .word 8, 9, 10, 11, 12, 13, 14, 15, 24, 25



.text

main:
	addi $sp, $sp, -40
 	sw $s0, 0($sp)
 	sw $s1, 4($sp)			#create a stack for inputs and machine code outputs
 	sw $s2 8($sp)
 	sw $s3, 12($sp)
 	sw $s4, 16($sp)
 	
 	sw $s0, 20($sp)
 	sw $s0, 24($sp)
 	sw $s0, 28($sp)
 	sw $s0, 32($sp)
 	sw $s0, 36($sp)
 	
 	li $v0, 4
 	la $a0, msg1
 	syscall				#store inputs to memory
 	
 	li $v0, 4
 	la $a0, msg2
 	syscall
 	
 	li $v0, 4
 	la $a0, input1
 	syscall
 	
 	li $v0, 5
 	syscall
 	
 	sw $v0, 0($sp)
 	
 	li $v0, 4
 	la $a0, input2
 	syscall
 	
 	li $v0, 5
 	syscall
 	
 	sw $v0, 4($sp)
 	
 	li $v0, 4
 	la $a0, input3
 	syscall
 	
 	li $v0, 5
 	syscall
 	
 	sw $v0, 8($sp)
 	
 	li $v0, 4
 	la $a0, input4
 	syscall
 	
 	li $v0, 5
 	syscall
 	
 	sw $v0, 12($sp)
 	
 	li $v0, 4
 	la $a0, input5
 	syscall
 	
 	li $v0, 5
 	syscall
 	
 	sw $v0, 16($sp)
 	
 	la $t0, register_table
 	add $s0, $t0, $zero				#get addresses for various tables in memory
 	addi $s1, $s0, 36
 	
 	la $t0, label_table
 	add $s2, $t0, $zero
 	
 	la $t0, register_value_table
 	add $s3, $t0, $zero
 	
 	addi $s5, $zero, 0				#create a counter for finding preceding types
 	
 	addi $v1, $zero, 0		
 	
 							#v1 will be used to store machine code instructions
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	li $v0, 4
 	la $a0, msg4
 	syscall
 	
 	processInput1:
 	
 	li $v0, 4					#process inputs 1-5 and return a machine code value to store onto stack
 	la $a0, n1					
 	syscall
 
 	
 	lw $t0, 0($sp)
 	
 	bne $t0, 1, inputSkip
 	
 	jal print_add_or
 	
 	j input1Done
 	
 	inputSkip:
 	
 	bne $t0, 2, inputSkip2
 	
 	jal print_addi_ori
 	
 	j input1Done
 	
 	inputSkip2:
 	
 	bne $t0, 3, inputSkip3
 	
 	jal print_add_or
 	
 	j input1Done
 	
 	inputSkip3:
 	
 	bne $t0, 4, inputSkip4
 	
 	jal print_addi_ori
 	
 	j input1Done
 	
 	inputSkip4:
 	
 	bne $t0, 5, inputSkip5
 	
 	jal print_lw_sw
 	
 	j input1Done
 	
 	inputSkip5:
 	
 	bne $t0, 6, inputSkip6
 	
 	jal print_lw_sw
 	
 	j input1Done
 	
 	inputSkip6:
 	
 	bne $t0, 7, inputSkip7
 	
 	jal print_j_bne_beq
 	
 	j input1Done
 	
 	inputSkip7:
 	
 	bne $t0, 8, inputSkip8
 	
 	jal print_j_bne_beq
 	
 	j input1Done
 	
 	inputSkip8:
 	
 	bne $t0, 9, inputSkip9
 	
 	jal print_j_bne_beq
 	
 	j input1Done
 	
 	inputSkip9:
 	
 	input1Done:
 	
 	addi $s5, $s5, 1
 	
 	sw $v1, 20($sp)					#store machine code in memory
 	addi $v1, $zero, 0
 	
 	
 	processInput2:
 	
 	li $v0, 4
 	la $a0, n2
 	syscall
 	
 	lw $t0, 4($sp)
 	
 	bne $t0, 1, inputSkip10
 	
 	jal print_add_or
 	
 	j input2Done
 	
 	inputSkip10:
 	
 	bne $t0, 2, inputSkip11
 	
 	jal print_addi_ori
 	
 	j input2Done
 	
 	inputSkip11:
 	
 	bne $t0, 3, inputSkip12
 	
 	jal print_add_or
 	
 	j input2Done
 	
 	inputSkip12:
 	
 	bne $t0, 4, inputSkip13
 	
 	jal print_addi_ori
 	
 	j input2Done
 	
 	inputSkip13:
 	
 	bne $t0, 5, inputSkip14
 	
 	jal print_lw_sw
 	
 	j input2Done
 	
 	inputSkip14:
 	
 	bne $t0, 6, inputSkip15
 	
 	jal print_lw_sw
 	
 	j input2Done
 	
 	inputSkip15:
 	
 	bne $t0, 7, inputSkip16
 	
 	jal print_j_bne_beq
 	
 	j input2Done
 	
 	inputSkip16:
 	
 	bne $t0, 8, inputSkip17
 	
 	jal print_j_bne_beq
 	
 	j input2Done
 	
 	inputSkip17:
 	
 	bne $t0, 9, inputSkip18
 	
 	jal  print_j_bne_beq
 	
 	j input2Done
 	
 	inputSkip18:
 	
 	input2Done:
 	
 	addi $s5, $s5, 1
 	
 	sw $v1, 24($sp)
 	addi $v1, $zero, 0
 	
 	
 	
 	processInput3:
 	
 	li $v0, 4
 	la $a0, n3
 	syscall
 	
 	lw $t0, 8($sp)
 	
 	bne $t0, 1, inputSkip19
 	
 	jal print_add_or
 	
 	j input3Done
 	
 	inputSkip19:
 	
 	bne $t0, 2, inputSkip20
 	
 	jal print_addi_ori
 	
 	j input3Done
 	
 	inputSkip20:
 	
 	bne $t0, 3, inputSkip21
 	
 	jal print_add_or
 	
 	j input3Done
 	
 	inputSkip21:
 	
 	bne $t0, 4, inputSkip22
 	
 	jal print_addi_ori
 	
 	j input3Done
 	
 	inputSkip22:
 	
 	bne $t0, 5, inputSkip23
 	
 	jal print_lw_sw
 	
 	j input3Done
 	
 	inputSkip23:
 	
 	bne $t0, 6, inputSkip24
 	
 	jal print_lw_sw
 	
 	j input3Done
 	
 	inputSkip24:
 	
 	bne $t0, 7, inputSkip25
 	
 	jal print_j_bne_beq
 	
 	j input3Done
 	
 	inputSkip25:
 	
 	bne $t0, 8, inputSkip26
 	
 	jal print_j_bne_beq
 	
 	j input3Done
 	
 	inputSkip26:
 	
 	bne $t0, 9, inputSkip27
 	
 	jal print_j_bne_beq
 	
 	j input3Done
 	
 	inputSkip27:
 	
 	input3Done:
 	
 	addi $s5, $s5, 1
 	
 	sw $v1, 28($sp)
 	addi $v1, $zero, 0
 	
 	processInput4:
 	
 	li $v0, 4
 	la $a0, n4
 	syscall
 	
 	lw $t0, 12($sp)
 	
 	bne $t0, 1, inputSkip28
 	
 	jal print_add_or
 	
 	j input4Done
 	
 	inputSkip28:
 	
 	bne $t0, 2, inputSkip29
 	
 	jal print_addi_ori
 	
 	j input4Done
 	
 	inputSkip29:
 	
 	bne $t0, 3, inputSkip30
 	
 	jal print_add_or
 	
 	j input4Done
 	
 	inputSkip30:
 	
 	bne $t0, 4, inputSkip31
 	
 	jal print_addi_ori
 	
 	j input4Done
 	
 	inputSkip31:
 	
 	bne $t0, 5, inputSkip32
 	
 	jal print_lw_sw
 	
 	j input4Done
 	
 	inputSkip32:
 	
 	bne $t0, 6, inputSkip33
 	
 	jal print_lw_sw
 	
 	j input4Done
 	
 	inputSkip33:
 	
 	bne $t0, 7, inputSkip34
 	
 	jal print_j_bne_beq
 	
 	j input4Done
 	
 	inputSkip34:
 	
 	bne $t0, 8, inputSkip35
 	
 	jal print_j_bne_beq
 	
 	j input4Done
 	
 	inputSkip35:
 	
 	bne $t0, 9, inputSkip36
 	
 	jal print_j_bne_beq
 	
 	j input4Done
 	
 	inputSkip36:
 	
 	input4Done:
 	
 	addi $s5, $s5, 1
 	
 	sw $v1, 32($sp)
 	addi $v1, $zero, 0
 	
 	processInput5:
 	
 	li $v0, 4
 	la $a0, n5
 	syscall
 	
 	lw $t0, 16($sp)
 	
 	bne $t0, 1, inputSkip37
 	
 	jal print_add_or
 	
 	j input5Done
 	
 	inputSkip37:
 	
 	bne $t0, 2, inputSkip38
 	
 	jal print_addi_ori
 	
 	j input5Done
 	
 	inputSkip38:
 	
 	bne $t0, 3, inputSkip39
 	
 	jal print_add_or
 	
 	j input5Done
 	
 	inputSkip39:
 	
 	bne $t0, 4, inputSkip40
 	
 	jal print_addi_ori
 	
 	j input5Done
 	
 	inputSkip40:
 	
 	bne $t0, 5, inputSkip41
 	
 	jal print_lw_sw
 	
 	j input5Done
 	
 	inputSkip41:
 	
 	bne $t0, 6, inputSkip42
 	
 	jal print_lw_sw
 	
 	j input5Done
 	
 	inputSkip42:
 	
 	bne $t0, 7, inputSkip43
 	
 	jal print_j_bne_beq
 	
 	j input5Done
 	
 	inputSkip43:
 	
 	bne $t0, 8, inputSkip44
 	
 	jal  print_j_bne_beq
 	
 	j input5Done
 	
 	inputSkip44:
 	
 	bne $t0, 9, inputSkip45
 	
 	jal print_j_bne_beq
 	
 	j input5Done
 	
 	inputSkip45:
 	
 	input5Done:
 	
 	sw $v1, 36($sp)					#print machine codes
 	addi $v1, $zero, 0
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	
 	li $v0, 4
 	la $a0, msg3
 	syscall
 	
 	li $v0, 11
	li $a0, 0x20
	syscall
 	
 	
 	li $v0, 34
 	lw $a0, 20($sp)
 	syscall
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	li $v0, 11
	li $a0, 0x20
	syscall
 	
 	li $v0, 34
 	lw $a0, 24($sp)
 	syscall
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	li $v0, 11
	li $a0, 0x20
	syscall
 	
 	li $v0, 34
 	lw $a0, 28($sp)
 	syscall
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	li $v0, 11
	li $a0, 0x20
	syscall
 	
 	li $v0, 34
 	lw $a0, 32($sp)
 	syscall
 	
 	li $v0, 4
 	la $a0, newLine
 	syscall
 	
 	li $v0, 11
	li $a0, 0x20
	syscall
 	
 	li $v0, 34
 	lw $a0, 36($sp)
 	syscall
 	
 	
 	
 					#restore stack and s registers
 	addi $sp, $sp, 40
 	add $s0, $zero, $zero
 	add $s1, $zero, $zero
 	add $s2, $zero, $zero
 	add $s3, $zero, $zero
 	add $s4, $zero, $zero				
 	add $s5, $zero, $zero
 					#exit the program
 	
 	li $v0, 10
 	syscall
 	
 	
 	
 	
 	
 	
 	
 	
 
 	
print_add_or:

	beq $t0, 3, goToOr

							#prints assembly for add and or
	goToAdd:				 	#also creates the machine code
	
		li $v0, 4
		la $a0, addPrint
		syscall
		
		li $t5, 32				#builds the machine code
		or $v1, $t5, $v1
		
		li $v0, 11
		li $a0, 0x20
		syscall
	
		j printAddReg
	
	goToOr:

		li $v0, 4
		la $a0, orPrint
		syscall
		
		li $t5, 37
		or $v1, $t5, $v1
		
		li $v0, 11
		li $a0, 0x20
		syscall

		j printAddReg
		
	printAddReg:					#prints the registers and builds the machine code
	
		checkPreceding2:
							#check for preceding to see if a register is linked
		beq $a3, $zero, noChange2
		
		beq $s1, $s0, resetChangeReg2
		
		addi $s3, $s3, 4
		addi $s0, $s0, 4
		
		j skipChangeReg2
		
		resetChangeReg2:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipChangeReg2:
		
		
		
		noChange2:
	
	
					
		add $t0, $s0, $zero
		
		lw $t5, ($s3)				#add a register value to the machine code
		sll $t5, $t5, 21
		or $v1, $t5, $v1
		
		addRegTwo:
		
		beq $s1, $s0, resetReg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipReg
		
		resetReg:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipReg:
		
		add $t1, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 16
		or $v1, $t5, $v1
		
		
		addRegThree:
		
		beq $s1, $s0, resetReg2
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipReg2
		
		resetReg2:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipReg2:
		
		add $t2 $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 11
		or $v1, $t5, $v1
		
		printAddRegs:
		
		li $v0, 4
		lw $t2, ($t2)
		la $a0, ($t2)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 4
		lw $t0, ($t0)
		la $a0, ($t0)
		syscall
						#prints all the registers
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 4
		lw $t1, ($t1)
		la $a0, ($t1)
		syscall
		
		li $v0, 4
 		la $a0, newLine
 		syscall
 		
 		addi $a3, $zero, 0
	
		jr $ra
	
	


print_addi_ori:

								
								#prints assembly and gets machine code for addi and ori
	beq $t0, 2, goToAddi
	
	beq $t0, 4, goToOri

	
	goToAddi:
	
		li $v0, 4
		la $a0, addiPrint
		syscall
		
		li $t5, 8
		sll $t5, $t5, 26
		or $v1, $v1, $t5
		
		li $v0, 11
		li $a0, 0x20
		syscall
	
		j printAddiOriRegs
	
	goToOri:
	
		li $v0, 4
		la $a0, oriPrint
		syscall
		
		li $t5, 13
		sll $t5, $t5, 26
		or $v1, $v1, $t5
		
		li $v0, 11
		li $a0, 0x20
		syscall
	
		j printAddiOriRegs
	
	
	
	
	printAddiOriRegs:
	
		checkPreceding:
		
		beq $a3, $zero, noChange
		
		beq $s1, $s0, resetChangeReg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipChangeReg
		
		resetChangeReg:
								#resets pointer register to t0 if program is at t9 and need another register
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipChangeReg:
		
		
		
		noChange:
	
		add $t0, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 21
		or $v1, $t5, $v1
		
	
		addiRegTwo:
	
		beq $s1, $s0, resetAddiReg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipAddiReg
		
		resetAddiReg:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipAddiReg:
		
		add $t1, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 16
		or $v1, $t5, $v1
		
		lw $t5, ($s2)
		or $v1, $t5, $v1
		
		li $v0, 4
		lw $t1, ($t1)
		la $a0, ($t1)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 4
		lw $t0, ($t0)
		la $a0, ($t0)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
								#prints immediate
		li $v0, 1
		lw $t0, ($s2)
		add $a0, $t0, $zero
		syscall
		
		addi $s2, $s2, 4
		
		li $v0, 4
 		la $a0, newLine
 		syscall
 		
 		addi $a3, $zero, 0

		jr $ra

print_j_bne_beq:

									#prints assemblyand gets machine code for j, bne and beq
		beq $t0, 7, printJReg
		
		beq $t0, 8, printBeqReg
		
		beq $t0, 9, printBneReg
		
	printJReg:
	
		li $v0, 4
		la $a0, jPrint
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 11
		li $a0, 0x4C
		syscall
		
		
		li $t5, 2				
		sll $t5, $t5, 26
		or $v1, $v1, $t5
		
		lw $t4, ($s2)
		
		addi $t5, $t4, -100
						#calculutes the immediate jump
		
		addi $t6, $zero, 4
		
		mul $t5, $t5, $t6
		
		addi $t5, $t5, 0x00400000
		
		srl $t5, $t5, 2
		
		or $v1, $v1, $t5
		
		
		
		li $v0, 1
		lw $t0, ($s2)
		add $a0, $t0, $zero
		syscall
		
		addi $s2, $s2, 4
		
		li $v0, 4
 		la $a0, newLine
 		syscall
 		
 		addi $a3, $zero, 1
		
		jr $ra
		
		
	printBneReg:
	
		li $t5, 5
		sll $t5, $t5, 26
		or $v1, $v1, $t5
		
		
		checkPreceding3:
		
		beq $a3, $zero, noChange3
	
		beq $s1, $s0, resetBne2Reg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipBne2Reg
		
		resetBne2Reg:
		
		addi $s0, $s0, -36
		addi $s0, $s0, -36
		
		skipBne2Reg:
		
		noChange3:
		
		li $v0, 4
		la $a0, bnePrint
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		add $t0, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 16
		or $v1, $t5, $v1
	
		BneRegTwo:
	
		beq $s1, $s0, resetBneReg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipBneReg
		
		resetBneReg:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipBneReg:
		
		add $t1, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 21
		or $v1, $t5, $v1
		
		li $v0, 4
		lw $t1, ($t1)
		la $a0, ($t1)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 4
		lw $t0, ($t0)
		la $a0, ($t0)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 11
		li $a0, 0x4C
		syscall
		
		li $v0, 1
		lw $t0, ($s2)
		add $a0, $t0, $zero
		syscall
							#calculates immediate jump for bne
		addi $t5, $t5, 0xffff
		lw $t7, ($s2)
		addi $t7, $t7, -100
		sub $t7, $s5, $t7
		sub $t5, $t5, $t7
		or $v1, $v1, $t5
		
		
		
		addi $s2, $s2, 4
		
		li $v0, 4
 		la $a0, newLine
 		syscall
		
		addi $a3, $zero, 1
		
		jr $ra
		
		
	printBeqReg:
		
		li $t5, 4
		sll $t5, $t5, 26
		or $v1, $v1, $t5
		
		checkPreceding4:
		
		beq $a3, $zero, noChange4
		
	
		beq $s1, $s0, resetBeq2Reg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipBeq2Reg
		
		resetBeq2Reg:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		noChange4:
		
		skipBeq2Reg:
	
		li $v0, 4
		la $a0, beqPrint
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		
		add $t0, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 16
		or $v1, $t5, $v1
	
		BeqRegTwo:
	
		beq $s1, $s0, resetBeqReg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skipBeqReg
		
		resetBeqReg:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipBeqReg:
		
		add $t1, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 21
		or $v1, $t5, $v1
		
		li $v0, 4
		lw $t1, ($t1)
		la $a0, ($t1)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 4
		lw $t0, ($t0)
		la $a0, ($t0)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 11
		li $a0, 0x4C
		syscall
		
		li $v0, 1
		lw $t0, ($s2)
		add $a0, $t0, $zero
		syscall
							#calculates imm jump for beq (same way as bne)
		addi $t5, $t5, 0xffff
		lw $t7, ($s2)
		addi $t7, $t7, -100
		sub $t7, $s5, $t7
		sub $t5, $t5, $t7
		or $v1, $v1, $t5
		
		addi $s2, $s2, 4
		
		li $v0, 4
 		la $a0, newLine
 		syscall
		
		addi $a3, $zero, 1
		
		jr $ra
		
		
		



print_lw_sw:
							#prints assembly and gets machine for lw and sw
	beq $t0, 5, printLwRegs
	beq $t0, 6, printSwRegs
	
	
	printLwRegs:
		
		li $v0, 4
		la $a0, lwPrint
		syscall
		
		li $t5, 35
		sll $t5, $t5, 26
		or $v1, $v1, $t5
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		checkPreceding5:
							#check for preceding to see if a register is linked
		beq $a3, $zero, noChange5
		
		beq $s1, $s0, resetChangeReg5
		
		addi $s3, $s3, 4
		addi $s0, $s0, 4
		
		j skipChangeReg5
		
		resetChangeReg5:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipChangeReg5:
		noChange5:
		
		addi $a3, $zero, 0
		
		j printLwSwRegs
	
	printSwRegs:
		
		li $v0, 4
		la $a0, swPrint
		syscall
		
		li $t5, 43
		sll $t5, $t5, 26
		or $v1, $v1, $t5
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		checkPreceding6:
							#check for preceding to see if a register is linked
		beq $a3, $zero, noChange6
		
		beq $s1, $s0, resetChangeReg6
		
		addi $s3, $s3, 4
		addi $s0, $s0, 4
		
		j skipChangeReg6
		
		resetChangeReg6:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skipChangeReg6:
		noChange6:
		
		addi $a3, $zero, 1
		
		j printLwSwRegs
	
	printLwSwRegs:
		add $t0, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 21
		or $v1, $t5, $v1
	
		lwRegTwo:
	
		beq $s1, $s0, resetlwReg
		
		addi $s0, $s0, 4
		addi $s3, $s3, 4
		
		j skiplwReg
		
		resetlwReg:
		
		addi $s0, $s0, -36
		addi $s3, $s3, -36
		
		skiplwReg:
		
		add $t1, $s0, $zero
		
		lw $t5, ($s3)
		sll $t5, $t5, 16
		or $v1, $t5, $v1
		
		lw $t5, ($s2)
		or $v1, $t5, $v1

					#prints lw and sw registers

		li $v0, 4
		lw $t1, ($t1)
		la $a0, ($t1)
		syscall
		
		li $v0, 11
		li $a0, 0x2C
		syscall
		
		li $v0, 11
		li $a0, 0x20
		syscall
		
		li $v0, 1
		lw $t2, ($s2)
		add $a0, $t2, $zero
		syscall
		
		addi $s2, $s2, 4
		
		li $v0, 11
		li $a0, 0x28
		syscall
		
		li $v0, 4
		lw $t0, ($t0)
		la $a0, ($t0)
		syscall

		li $v0, 11
		li $a0, 0x29
		syscall
		
		li $v0, 4
 		la $a0, newLine
 		syscall
 		
		
		jr $ra
		
