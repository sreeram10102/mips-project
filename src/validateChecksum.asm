	.data
array:
 .space 24
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
li $t4 0 #t0 is my extra array where i am storing my value from #a0
#li $t0 0
addiu $a0 $a0 4
la $t0 array
 whole:
lb $t2 ($a0)
sb $t2 ($t0)
addiu $t4 $t4 1
addiu $t0 $t0 1
addiu $a0 $a0 1
beq $t4 18 loop1
b whole

loop1:
li $t9 10 
subiu $a0 $a0 22
lb $t2 ($a0)
addiu $t2 $t2 -55
div $t2 $t9

mflo $t1
mfhi $s1
addiu $t1 $t1 48
addiu $s1 $s1 48
sb $t1 ($t0)
addiu $t0 $t0 1
sb $s1 ($t0)
addiu $t0 $t0 1
addiu $a0 $a0 1
lb $t2 ($a0)
addiu $t2 $t2 -55
div $t2 $t9
mflo $t1 
mfhi $s1
addiu $t1 $t1 48
addiu $s1 $s1 48
sb $t1 ($t0)
addiu $t0 $t0 1
sb $s1 ($t0)
addiu $t0 $t0 1
addiu $a0 $a0 1
li $t4 0 
loop2:
lb $t2 ($a0)
sb $t2 ($t0)
addiu $t4 $t4 1
addiu $a0 $a0 1
addiu $t0 $t0 1
beq $t4 2 end1
b loop2

end1: #retransfering it to a0 register
move $a0 $t0
subiu $a0 $a0 24
li $a1 24
li $a2 97

modulo_str:
addiu $a0 $a0 0
li $t0 0 #$t0 remainder
li $t3 0
addiu $t0 $t0 0
give:
lb $t2 ($a0)
addiu $t2 $t2 -48 #$t1 is the divident and $t0 remainder and $a2 is divisor
mul $t0 $t0 10
add $t0 $t0 $t2
div $t0 $a2
mfhi $t0 
addiu $a1 $a1 -1
addiu $a0 $a0 1
beqz $a1 end
b give

end :
move $v0 $t0
jr $ra

