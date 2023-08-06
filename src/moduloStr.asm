	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 

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
	
