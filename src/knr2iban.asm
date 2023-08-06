.data
	.globl knr2iban
	array:
 .space 24
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
li $t0 'D'
sb $t0 0($a0)
addiu $a0 $a0 1
li $t7 'E'
sb $t7 ($a0)
addiu $a0 $a0 1
li $s3 '0'
sb $s3 ($a0)
addiu $a0 $a0 1
li $s4 '0'
sb $s4 ($a0)
addiu $a0 $a0 1

addiu $t8 $t8 4

first:
lb $t9 ($a1)
sb $t9 ($a0)
addiu $t8 $t8 1
addiu $a1 $a1 1
addiu $a0 $a0 1
beq $t8 12 second
b first		# branch t
 

second:
lb $t9 ($a2)
sb $t9 ($a0)
addiu $t8 $t8 1
addiu $a2 $a2 1
addiu $a0 $a0 1
beq $t8 22 looper
j second
    
looper:
subiu $a0 $a0 22
#addiu $sp $sp -4
move $s4 $ra 
move $s5 $a0
#sw $ra 0($sp)
jal validate_checksum
#lw $ra 0($sp)
#addiu $sp $sp 4
move $ra $s4
move $a0 $s5
move $t3 $v0
#addiu $a0 $a0 -4
li $s7 98
sub $t3 $s7 $t3
bgt $t3 10 inject

set :
	addiu $t3 $t3 48
	sb $t3 3($a0)
	j end

	inject:
	li $t1 10
	div $t3 $t1
	mflo $t1
    mfhi $s1
    addiu $t1 $t1 48
    addiu $s1 $s1 48
	sb $t1 2($a0)
	sb $s1 3($a0)
	

	end: 
	
	jr	$ra
