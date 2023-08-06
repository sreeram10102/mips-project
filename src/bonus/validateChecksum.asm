	.data
	.globl validate_checksum
	.text


# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
addiu $a0 $a0 0
validate_checksum:
li $a1 22
li $a2 97
lb $t1 ($a0)
addiu $a0 $a0 1
lb $t2 ($a0)
addiu $a0 $a0 1
lb $t3 ($a0)
addiu $a0 $a0 1
lb $t4 ($a0)	
li $s1 10
addiu $t1 $t1 -55
div $t1 $s1
mflo $t1
mfhi $s2
addiu $t1 $t1 48
addiu $s2 $s2 48
addiu $t2 $t2 -55
div $t2 $s1
mflo $t2
mfhi $s3
addiu $t2 $t2 48
addiu $s3 $s3 48
addiu $t6 $a0 0
addiu $t5 $a0 4

getme:
lb $t9 ($t5)
addiu $t5 $t5 1
sb $t9 ($t6)
addiu $t6 $t6 1
beq $t6 18 giveme
j getme

giveme:
addiu $a0 $a0 18
sb $t1 ($a0)
addiu $a0 $a0 1
sb $s2 ($a0)
addiu $a0 $a0 1
sb $t2 ($a0)
addiu $a0 $a0 1
sb $s3 ($a0)
addiu $a0 $a0 1
sb $t3 ($a0)
addiu $a0 $a0 1
sb $t4 ($a0)

end6:
  modulo_str:
addiu $a0 $a0 0
li $t0 0 #$t0 remainder
li $t3 0
addiu $t0 $t0 0
give:
lb $t2 ($a0)
addiu $t2 $t2 -48 #$t1 is the divident and $t0 remainder and $a2 is divisor
mul $t0 $t0 10
addu $t0 $t0 $t2
remu $t0 $t0 $a2
addiu $a1 $a1 -1
addiu $a0 $a0 1 #change
beqz $a1 end
#addiu $a0 $a0 1
#beqz $t2 end
b give


end :
move $v0 $t0
jr $ra
	

	
